# hjklmode.vim - hjkl navigation in all Vim modes

## Introduction

The Vim plugin hjklmode.vim will help you to **break the habit** of using the keys that make you move your hand away from the touch type position.

It will disable the keys: Backspace, +, -, Insert, Delete, Home, End, Page Up and Page Down, Arrows and Escape (the Escape key will only be disabled in GUI mode because terminal emulators receive the character \<Ctrl-[> when the user presses \<Esc>).

It will also allow you to use hjkl navigation in all Vim modes:
- **hjkl** in normal mode.
- **\<Alt\> + hjkl** in Insert Mode, Command Mode, and Terminal Mode.

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

## License

Copyright (c) [James Cherti](https://www.jamescherti.com).

Distributed under terms of the MIT license.

## Installation

### Installation with Vim's built-in package manager (Vim 8 and above)

#### Unix / Linux

```bash
mkdir -p ~/.vim/pack/jamescherti/start
cd ~/.vim/pack/jamescherti/start
git clone --depth 1 https://github.com/jamescherti/vim-hjklmode.git
vim -u NONE -c "helptags hjklmode/doc" -c q
```

#### Windows

Run the following commands in the "Git for Windows" Bash terminal:
```bash
mkdir -p ~/vimfiles/pack/jamescherti/start
cd ~/.vim/pack/jamescherti/start
git clone --depth 1 https://github.com/jamescherti/vim-hjklmode.git
vim -u NONE -c "helptags hjklmode/doc" -c q
```

### Installation with a third-party plugin manager

You can also install this Vim plugin with any third-party plugin manager such as Pathogen or Vundle.

## Links

- The Git repository of 'hjklmode': https://github.com/jamescherti/vim-hjklmode
