# hjklmode.vim - add hjkl navigation to all Vim modes

## Introduction

The hjklmode.vim will help you to **break the habit** of using the keys that make you move your hand away from the touch type position.

It will disable the keys: Backspace, +, -, Insert, Delete, Home, End, Page Up and Page Down, Arrows and Escape (the Escape key will only be disabled in GUI mode because terminal emulators receive the character \<Ctrl-[> when the user presses \<Esc>).

It will also allow you to use hjkl navigation in all Vim modes:
- **hjkl** in normal mode.
- **\<Alt\> + hjkl** in Insert Mode, Command Mode, and Terminal Mode.

## Author and license

Copyright (c) [James Cherti](https://www.jamescherti.com).

Distributed under terms of the MIT license.

## Do you like hjklmode.vim?

Please [star hjklmode.vim on GitHub](https://github.com/jamescherti/hjklmode.vim).

## Installation

### Installation with Vim's built-in package manager (Vim 8 and above)

```bash
mkdir -p ~/.vim/pack/jamescherti/start
cd ~/.vim/pack/jamescherti/start
git clone --depth 1 https://github.com/jamescherti/hjklmode.vim
vim -u NONE -c "helptags hjklmode.vim/doc" -c q
```

### Installation with a third-party plugin manager

You can also install this Vim plugin with any third-party plugin manager such as Pathogen or Vundle.

## How to enable hjklmode by default?
Add the following variable to "~/.vimrc":
```
let g:hjklmode_enabled = 1
```

## How can I move the cursor, press Escape or Backspace when hjklmode.vim is enabled?

| Key mapping  | Equivalent to
|--------------|---------------
| Ctrl-[       | Escape
| Ctrl-h       | Backspace
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
