# hjklmode.vim - Learn hjkl navigation!

## Introduction

The Vim plugin Hjklmode will help you to **break the habit** of using the keys that make you move your hand away from the touch type position.

It will disable the keys: Backspace, Arrows, +, -, Insert, Delete, Home, End, Page Up and Page Down.

Hjklmode will not disable the Escape key by default. The Escape key can be disabled with the option `let g:hjklmode_disable_escape = 1` (However, the option `g:hjklmode_disable_escape` will be ignored by Hjklmode when Vim is executed in a terminal or on the Windows operating system).

It will also allow you to use hjkl navigation in all Vim modes:
- **hjkl** in normal mode.
- \<Alt> + hjkl in Insert Mode, Command Mode, and Terminal Mode (it works in Vim GUI mode but not always when Vim is executed in a terminal. Make sure the terminal does not grab the \<Alt> key).

## Do you like Hjklmode?

Please [star vim-hjklmode on GitHub](https://github.com/jamescherti/vim-hjklmode).

## Installation

### Installation with Vim's built-in package manager (Vim 8 and above)

```shell
mkdir -p ~/.vim/pack/jamescherti/start
cd ~/.vim/pack/jamescherti/start
git clone --depth 1 https://github.com/jamescherti/vim-hjklmode
vim -u NONE -c "helptags vim-hjklmode/doc" -c q
```

### Installation with a third-party plugin manager

You can also install this Vim plugin with any third-party plugin manager such as Pathogen or Vundle.

## How to enable Hjklmode by default?
Add the following variable to "~/.vimrc":
```viml
" Disable the menu bar because it may prevent you from using the Alt key
set guioptions-=m

" Enable Hjklmode by default
let g:hjklmode_enabled = 1

" It is recommended to not disable the Escape key.
" Disabling the Escape can cause issues with macros.
let g:hjklmode_disable_escape = 0
```

## How to enable Hjklmode manually?
```viml
:HjklmodeEnable
```

## How can I move the cursor, press Escape or Backspace when Hjklmode is enabled?

Vim key mappings:
| Key mapping  | Equivalent to
|--------------|---------------------------------------------------
| Ctrl-[       | Escape (if you have an American English keyboard)
| Ctrl-C       | Similar to Escape (check *:help i_CTRL-C*)
| Ctrl-h       | Backspace
| Ctrl-j       | Enter
| Ctrl-m       | Enter
| Ctrl-i       | Tab
| Ctrl-f       | Page down
| Ctrl-b       | Page up
| h            | Left
| j            | Down
| k            | Up
| l            | Right
| 0 (zero)     | Home
| $            | End

For more information:
- :help motion.txt
- :help search-commands

## Author and license

Copyright (c) [James Cherti](https://www.jamescherti.com).

Distributed under terms of the MIT license.
