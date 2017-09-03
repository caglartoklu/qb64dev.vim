# qb64dev.vim

Opens and compiles `.bas` files with [QB64](http://www.qb64.net/) within Vim.

See the _commands_ section below for screenshots.

Quoting from Wikipedia;
_QB64 is a self-hosting [BASIC](https://en.wikipedia.org/wiki/BASIC) compiler for Microsoft Windows, Linux and Mac OS X, designed to be compatible with Microsoft [QBasic](https://en.wikipedia.org/wiki/QBasic) and [QuickBASIC](https://en.wikipedia.org/wiki/QuickBASIC). QB64 is a C++ emitter, which is integrated with a C++ compiler to provide compilation via C++ code and GCC optimization._

_QB64 implements most QBasic statements, and can run many QBasic programs, including Microsoft's QBasic Gorillas and Nibbles games._

_Furthermore, QB64 has been designed to contain an IDE resembling the QBASIC IDE. QB64 also extends the QBASIC programming language to include 64-bit data types, as well as better sound and graphics support. It can also emulate some DOS/x86 specific features such as INT 33h mouse access, and timers._


# Requirements

- [QB64](http://www.qb64.net/)
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

Compiles and runs the `.bas` file in Vim buffer with QB64.
The executable file will be in the same path as the `.bas` file.

![qb64run](https://user-images.githubusercontent.com/2071639/30004688-952904fa-90dc-11e7-871b-68a9c1e603a9.gif)


### `QB64Open`

Opens the current buffer in QB64 IDE.
This can be useful to squash a bug or use the inline help system in QB64 IDE.

![qb64open](https://user-images.githubusercontent.com/2071639/30004689-99605b40-90dc-11e7-84f5-759f5cb5d934.gif)


# FAQ

### Do I really need QB64 to use this plugin?

Technically no, but, without QB64 itself, this plugin would be pointless.

### Why would I use qb64dev.vim instead of official QB64 IDE?

QB64 IDE has its own advantages like code formatting, showing errors, and built-in help as in QuickBASIC. But, if you use Vim for all your coding, you may want to use it for QuickBASIC as well. And, qb64.vim provides a way to use it.

### What is the name of the colorscheme in screenshots?

That would be a new colorscheme that is not released yet. This page will be updated when it is released with a link to colorscheme.

### What is the syntax file you are using for screenshots?

That is [FreeBASIC syntax file](https://github.com/vim-scripts/Freebasic-vim-syntax-file).


# License

Licensed with
[2-clause license](https://en.wikipedia.org/wiki/BSD_licenses#2-clause_license_.28.22Simplified_BSD_License.22_or_.22FreeBSD_License.22.29)
("Simplified BSD License" or "FreeBSD License").
See the
[LICENSE.txt](LICENSE.txt) file.
