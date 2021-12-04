# hjklmode.vim - Learn hjkl navigation!

## Introduction

The Vim plugin hjklmode will help you to **break the habit** of using the keys that make you move your hand away from the touch type position.

It will disable the keys: Backspace, +, -, Insert, Delete, Home, End, Page Up and Page Down, Arrows and Escape (Backspace and Escape keys will only be disabled in Vim GUI mode because terminal emulators receive the same character for \<Ctrl-[> and \<Esc>).

It will also allow you to use hjkl navigation in all Vim modes:
- **hjkl** in normal mode.
- \<Alt> + hjkl in Insert Mode, Command Mode, and Terminal Mode (it works in Vim GUI mode but not always when Vim is executed in a terminal. Make sure the terminal does not grab the \<Alt> key).

## Author and license

Copyright (c) [James Cherti](https://www.jamescherti.com).

Distributed under terms of the MIT license.

## Do you like hjklmode?

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

## How to enable hjklmode by default?
Add the following variable to "~/.vimrc":
```viml
let g:hjklmode_enabled = 1
```

## How to enable hjklmode manually?
```viml
:HjklmodeEnable
```

## How can I move the cursor, press Escape or Backspace when hjklmode is enabled?

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
