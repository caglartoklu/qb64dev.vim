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


function! s:StrRight(input_string, length)
    " Returns the rightmost n characters of a string.
    let length2 = a:length
    if (length2 < 0)
        let length2 = 0
    endif
    let result = a:input_string
    if length2 < strlen(a:input_string)
        let istart = strlen(a:input_string) - length2
        " strpart( {src}, {start}[, {len}])
        let result = strpart(a:input_string, istart, length2)
    endif
    return result
endfunction


function! QB64Dev#FileExists(file_name)
    " Returns 1 if the file exists, 0 otherwise.
    let result = 0
    if filereadable(a:file_name)
        result = 1
    endif
    return result
endfunction


function! QB64Dev#ExeName()
    " Returns the executable name of QB64.
    " '.exe' is not added for Linux and Mac compatibility.
    return 'qb64'
endfunction


function! QB64Dev#QB64Dir()
    " Returns the directory of QB64.

    let result = ""
    if exists('g:qb64dev_qb64_directory')
        let result = g:qb64dev_qb64_directory
    else
        if exists('g:qb64dev_autofind_qb64')
            if g:qb64dev_autofind_qb64 == 1
                let candidate_directories = []
                call add(candidate_directories, 'C:\\QB64')
                call add(candidate_directories, 'C:\\qb64-1.1-20170120.51-win')
                call add(candidate_directories, 'C:\\bin\\QB64')
                call add(candidate_directories, 'C:\\bin\\qb64-1.1-20170120.51-win')
                call add(candidate_directories, 'C:\\Program Files\\QB64')
                call add(candidate_directories, 'C:\\Program Files\\qb64-1.1-20170120.51-win')
                call add(candidate_directories, 'C:\\Program Files (x86)\\QB64')
                call add(candidate_directories, 'C:\\Program Files (x86)\\qb64-1.1-20170120.51-win')
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
    return result
endfunction


function! QB64Dev#QB64ExePath()
    " Returns the path to QB64 IDE/compiler.
    let result = QB64Dev#QB64Dir()
    if s:StrRight(result, 1) == '/'
        let result = result . QB64Dev#ExeName()
    elif s:StrRight(result, 1) == '\\'
        let result = result . QB64Dev#ExeName()
    else
        let result = result . '/' . QB64Dev#ExeName()
    endif
    " Decho 'QB64Dev#QB64ExePath() : ' . result
    return result
endfunction


function! QB64Dev#QB64Compile()
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
    let curdir = getcwd()
    let currentfilename = expand("%:p")
    let qb64dir = QB64Dev#QB64Dir()
    " Decho 'qb64dir : ' . qb64dir
    " exec 'cd ' . qb64dir
    call system(QB64Dev#ExeName() .' -c ' . currentfilename)
    " exec 'cd ' . curdir
endfunction
command! -nargs=0 QB64Compile : call QB64Dev#QB64Compile()


function! QB64Dev#QB64Run()
    " Compiles and then runs the current file with QB64.
    call QB64Dev#QB64Compile()

    let currentfilename = expand("%:p")
    " remove the last .bas extension from file name:
    let exefilename = substitute(currentfilename, '\.\(b\|B\)\(a\|\A\)\(s\|S\)$', '', '')

    " the remainder should be the name of the exe file.
    call system(exefilename)
endfunction
command! -nargs=0 QB64Run : call QB64Dev#QB64Run()


function! QB64Dev#QB64Open()
    " Opens the current file with QB64 IDE.
    let currentfilename = expand("%:p")
    call system(QB64Dev#QB64ExePath() . ' ' . currentfilename)
endfunction
command! -nargs=0 QB64Open : call QB64Dev#QB64Open()


" mark that plugin loaded
let g:qb64dev_loaded= 1


" Define the settings once.
call s:SetDefaultSettings()
