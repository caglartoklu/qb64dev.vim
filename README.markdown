# qb64dev.vim

A Vim mode to edit [QB64](http://www.qb64.org/) BASIC files, including commands to opens/compiles/run them with QB64 IDE.

See the _commands_ section below for screenshots and features.

Quoting from [QB64 on Wikipedia](https://en.wikipedia.org/wiki/QB64);
_QB64 is a self-hosting [BASIC](https://en.wikipedia.org/wiki/BASIC) compiler for Microsoft Windows, Linux and Mac OS X, designed to be compatible with Microsoft [QBasic](https://en.wikipedia.org/wiki/QBasic) and [QuickBASIC](https://en.wikipedia.org/wiki/QuickBASIC). QB64 is a C++ emitter, which is integrated with a C++ compiler to provide compilation via C++ code and GCC optimization._

_QB64 implements most QBasic statements, and can run many QBasic programs, including Microsoft's QBasic Gorillas and Nibbles games._

_Furthermore, QB64 has been designed to contain an IDE resembling the QBASIC IDE._

See more on [QB64 on Wikipedia](https://en.wikipedia.org/wiki/QB64).


# Requirements

- [QB64](http://www.qb64.org/) :
Simply download and install QB64 to a directory of your choice.
QB64 is available for Windows, Linux and Mac OS X.


# Installation

For [Vundle](http://github.com/VundleVim/Vundle.Vim) users:

```
Plugin 'caglartoklu/qb64dev.vim'
```

For all other users, simply drop the [plugin/qb64dev.vim](plugin/qb64dev.vim) file to your `plugin` directory.


# Configuration

### `g:qb64dev_qb64_directory`

The installation directory of QB64.

Default :

```
unavailable.
```

example:


```
g:qb64dev_qb64_directory = 'C:\bin\qb64'
```


### `g:qb64dev_autofind_qb64`

If `g:qb64dev_qb64_directory` is not defined, and `g:qb64dev_autofind_qb64` is `1`, which is the default, then qb64dev.vim will check a few paths to locate QB64 directory.

Note that `g:qb64dev_qb64_directory` will override this setting if defined.

Default:

```
let g:qb64dev_autofind_qb64 = 1
```


# Commands

### `QB64Compile`

Compiles the `.bas` file in Vim buffer with QB64.
The executable file will be in the same path as the `.bas` file.

![qb64compile](https://user-images.githubusercontent.com/2071639/30004685-90d35978-90dc-11e7-9441-d0c395ae16bf.gif)


### `QB64Run`

Runs the compiled executable file.
The executable file must be in the same path as the `.bas` file.

![qb64run](https://user-images.githubusercontent.com/2071639/30004688-952904fa-90dc-11e7-871b-68a9c1e603a9.gif)


### `QB64CompileAndRun`

Compiles the `.bas` file in Vim buffer with QB64 and executes it.
The executable file must be in the same path as the `.bas` file.


### `QB64Open`

Opens the current buffer in QB64 IDE.
This can be useful to squash a bug or use the inline help system in QB64 IDE.

![qb64open](https://user-images.githubusercontent.com/2071639/30004689-99605b40-90dc-11e7-84f5-759f5cb5d934.gif)



# Recommended Settings

## Map `F5` for `Run` and `F11` for `Make Exe Only`

```viml
au BufEnter,BufNew *.bas nnoremap <F5> : call qb64dev#QB64CompileAndRun()<cr>
au BufEnter,BufNew *.bas nnoremap <F11> : call qb64dev#QB64Compile()<cr>
```


## Tab Completion for Dictionary

Note that qb64dev.vim only provides the dictionary.

That dictionary can be used with Vim's standard [dictionary completion](https://vim.fandom.com/wiki/Dictionary_completions) keys (`CTRL X CTRL K`) or any other compatible [Vim completion plugin](https://vimawesome.com/?q=tag:autocomplete).

The following code sample is for [VimCompletesMe](https://github.com/ajh17/VimCompletesMe).

```viml
au BufEnter,BufNew *.bas let b:vcm_tab_complete = 'dict'
```

In the following animated gif, **TAB** key makes the completion:

![qb64_code_completion](https://user-images.githubusercontent.com/2071639/78508199-a4f78380-778d-11ea-8422-1dabd45898b6.gif)


# FAQ

### Do I really need QB64 to use this plugin?

Technically no, but, without QB64 itself, this plugin would be pointless.

### Why would I use qb64dev.vim instead of official QB64 IDE?

First of all, QB64 IDE is retro-classic, and nothing beats that :)

Moreover, QB64 IDE has its own advantages like code formatting, showing errors, and built-in help as in QuickBASIC.

But, if you use Vim for all your coding, you may want to use it for QuickBASIC as well. And, qb64dev.vim provides a way to use it.

In addition, qb64dev.vim provides a dictionary to use with Vim's dictionary completion.



### What is the name of the colorscheme in screenshots?

It is qbcolor.vim and it can be found here [here](https://github.com/caglartoklu/qbcolor.vim).

It is a separate plugin. It must be installed separately and used as follows:

```viml
Plugin 'caglartoklu/qbcolor.vim'

colorscheme qbcolor
```


### What is the syntax file you are using for screenshots?

That is [FreeBASIC syntax file](https://github.com/vim-scripts/Freebasic-vim-syntax-file).

It is a separate plugin. It must be installed separately and used as follows:

```viml
Plugin 'vim-scripts/Freebasic-vim-syntax-file'

autocmd BufNewFile,BufRead *.bas set ft=freebasic
autocmd BufNewFile,BufRead *.bi set ft=freebasic
```


# To Do

- [x] Compile, Run features.
- [x] Code completion.
- [x] Test on Windows.
- [ ] Test on Linux.
- [ ] Test on macOS.
- [ ] Embedding help files.
- [ ] A script to automatically download keywords list from QB64 wiki.
- [ ] QB64 specific syntax file.
- [ ] QB64 specific snippets for [vim-snipmate](https://github.com/garbas/vim-snipmate).
- [ ] Passing external arguments when running.
- [ ] Passing external complation options when compiling.
- [ ] [vim-quickui](https://github.com/skywind3000/vim-quickui) integration (maybe?).


# License

Licensed with
[2-clause license](https://en.wikipedia.org/wiki/BSD_licenses#2-clause_license_.28.22Simplified_BSD_License.22_or_.22FreeBSD_License.22.29)
("Simplified BSD License" or "FreeBSD License").
See the
[LICENSE.txt](LICENSE.txt) file.
