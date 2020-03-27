" -*- vim -*-
" FILE: qb64dev.vim
" PLUGINTYPE: plugin
" DESCRIPTION: Opens, compiles and runs BASIC Vim buffers with QB64 IDE and compiler.
" HOMEPAGE: https://github.com/caglartoklu/qb64dev.vim
" LICENSE: https://github.com/caglartoklu/qb64dev.vim/blob/master/LICENSE
" AUTHOR: caglartoklu, engintoklu


if exists('g:qb64dev_loaded') || &cp
    " If it already loaded, do not load it again.
    finish
endif


function! s:SetDefaultSettings()
    " Set the default settings.

    " User defined QB64 directory.
    " This will override the autofind if it is defined.
    " g:qb64dev_qb64_directory
    " This is not mandatory.

    " If the user has not defined the QB64 directory,
    " and if this option is 1,
    " the plugin will try a few directry names to find QB64 directory.
    if !exists('g:qb64dev_autofind_qb64')
        let g:qb64dev_autofind_qb64 = 1
    endif
endfunction


function! s:StrRight(haystack, needleLength)
    " Returns some characters at the end of a string
    " from the right side, just like Visual Basic.
    " let x = s:Right("abc", 0)
    " Decho x " ''
    " let x = s:Right("abc", 1)
    " Decho x " 'c'
    " let x = s:Right("abc", 2)
    " Decho x " 'bc'
    " let x = s:Right("abc", 3)
    " Decho x " 'abc'
    " let x = s:Right("abc", 5)
    " Decho x " 'abc'
    let iStart = strlen(a:haystack) - a:needleLength
    return strpart(a:haystack, iStart, a:needleLength)
endfunction


function! qb64dev#FileExists(file_name)
    " Returns 1 if the file exists, 0 otherwise.
    let result = 0
    if filereadable(a:file_name)
        result = 1
    endif
    return result
endfunction


function! qb64dev#ExeName()
    " Returns the executable name of QB64.
    " '.exe' is not added for Linux and Mac compatibility.
    return 'qb64'
endfunction


function! qb64dev#QB64Dir()
    " Returns the directory of QB64.

    let result = ""
    if exists('g:qb64dev_qb64_directory')
        let result = g:qb64dev_qb64_directory
    else
        if exists('g:qb64dev_autofind_qb64')
            if g:qb64dev_autofind_qb64 == 1
                let candidate_directories = []
                call add(candidate_directories, 'C:\\QB64')
                call add(candidate_directories, 'C:\\bin\\QB64')
                call add(candidate_directories, 'C:\\Program Files\\QB64')
                call add(candidate_directories, 'C:\\Program Files (x86)\\QB64')
                call add(candidate_directories, 'C:\\PortableApps\\qb64')
                call add(candidate_directories, 'D:\\QB64')
                call add(candidate_directories, 'D:\\bin\\QB64')
                call add(candidate_directories, 'D:\\Program Files\\QB64')
                call add(candidate_directories, 'D:\\Program Files (x86)\\QB64')
                call add(candidate_directories, 'D:\\PortableApps\\qb64')
                " TODO: 5 add Linux directories here.
                " TODO: 6 check if there is a qb64 executable on path,
                " locate it with `which`, and extract its directory.

                for item in candidate_directories
                    if isdirectory(item)
                        let result = item
                        break
                    endif
                endfor
            endif
        endif
    endif
    " Decho "result: " . result
    return result
endfunction


function! qb64dev#QB64ExePath()
    " Returns the path to QB64 IDE/compiler.
    let result = qb64dev#QB64Dir()
    " ==? is the case-insensitive no matter what the user has set
    " https://learnvimscriptthehardway.stevelosh.com/chapters/22.html
    if s:StrRight(result, 1) ==? '/'
        let result = result . qb64dev#ExeName()
    elseif s:StrRight(result, 1) ==? '\'
        let result = result . qb64dev#ExeName()
    else
        let result = result . '/' . qb64dev#ExeName()
    endif
    " Decho 'qb64dev#QB64ExePath() : ' . result
    return result
endfunction


function! qb64dev#QB64Compile()
    " Compiles the current file with QB64.

    " http://www.qb64.net/forum/index.php?topic=3893.0
    " -c    Compile file
    " -x    As -c, but use the console instead of a graphical window for progress reporting. My favourite.
    " -z    Do not compile generated C++ code.
    " -q    Compile for Qloud.
    " -g    Do not include graphics runtime (equivalent to $CONSOLE:ONLY I think, but don't quote me on that)
    " All switches imply -c; -z and -q imply -x.
    " Options must proceed the filename.
    " -- can be used as a dummy option to force the next thing to be a file (ordinaraily, -crapfile.bas would be interpreted as the -c switch)

    " source file 'test.bas'
    "     print 10
    "     var1 = NOTDEFINED1$()
    "     var2 = NOTDEFINED2$()
    "     print 20

    " compilation:
    "     qb64 -x c:\full\path\to\test.bas
    "     QB64 Compiler V1.4
    "
    "     Beginning C++ output from QB64 code... first pass finished.
    "     Translating code...
    "     [................                                  ] 33%
    "     Illegal string-number conversion
    "     Caused by (or after):VAR1 = NOTDEFINED1$ ( )
    "     LINE 2:var1 = NOTDEFINED1$()

    let curdir = getcwd()
    let currentfilename = expand("%:p")
    let qb64dir = qb64dev#QB64Dir()
    " Decho 'qb64dir : ' . qb64dir
    " exec 'cd ' . qb64dir

    " why used '-c' instead of '-x' ?
    " because, -x uses console and there is key press, and the output can not be seen by user.
    " on the other hand, `-c` uses graphical window and waits for key press.
    call system(qb64dev#QB64ExePath() . ' -c ' . currentfilename)
    " exec 'cd ' . curdir
endfunction
command! -nargs=0 QB64Compile : call qb64dev#QB64Compile()


function! qb64dev#QB64Run()
    " Runs the compiled exe file.

    let currentfilename = expand("%:p")
    " remove the last .bas extension from file name:
    let exefilename = substitute(currentfilename, '\.\(b\|B\)\(a\|\A\)\(s\|S\)$', '', '')

    " the remainder should be the name of the exe file.
    call system(exefilename)
endfunction
command! -nargs=0 QB64Run : call qb64dev#QB64Run()


function! qb64dev#QB64CompileAndRun()
    " Compiles and then runs the current file with QB64.
    call qb64dev#QB64Compile()
    call qb64dev#QB64Run()
endfunction
command! -nargs=0 QB64CompileAndRun : call qb64dev#QB64CompileAndRun()


function! qb64dev#QB64Open()
    " Opens the current file with QB64 IDE.
    let currentfilename = expand("%:p")
    call system(qb64dev#QB64ExePath() . ' ' . currentfilename)
endfunction
command! -nargs=0 QB64Open : call qb64dev#QB64Open()


" mark that plugin loaded
let g:qb64dev_loaded= 1


" Define the settings once.
call s:SetDefaultSettings()
