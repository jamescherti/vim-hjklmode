# hjklmode.vim - Add HJKL navigation to all Vim modes!

Copyright (c) [James Cherti](https://www.jamescherti.com). Distributed under terms of the MIT license.

## Introduction

### HJKL navigation?

Vim’s popularity is largely due to its ability to increase productivity through efficient navigation and editing techniques. One such technique is HJKL navigation, which allows using the H, J, K, and L keys to move the cursor left, down, up, and right. This method of navigation may seem strange at first, but it is actually a very efficient way to navigate through text and can greatly increase productivity when using Vim.

### The Vim plugin Hjklmode

The Vim plugin **Hjklmode** can be used to:
- **Learn HJKL navigation:** Hjklmode forces you to learn HJKL navigation as it disables certain keys that require moving the hand away from the Touch Typing position, which can disrupt typing flow. These keys include: Backspace, Arrows, Insert, Delete, Home, End, Page Up and Page Down.
- **Add HJKL navigation to other modes than Normal Mode:** Hjklmode adds the key mappings \<Alt>+hjkl to Insert Mode, Command Mode, and Terminal Mode.

Hjklmode does not disable the Escape key by default. It can be disabled with the option `let g:hjklmode_disable_escape = 1` . It is important to note that Hjklmode ignores the option `g:hjklmode_disable_escape` when Vim is executed in a terminal or on the Windows operating system.

### How to make Alt+hjkl work in Terminal Mode?

Hjklmode adds key mappings for \<Alt>+hjkl which allows using HJKL navigation Insert Mode, Command Mode, and Terminal Mode.

It works well in Vim GUI mode (gvim), but **does not always work when Vim is executed in a terminal**.

You can make the key mappings \<Alt>+hjkl work by making sure that the terminal does not grab the \<Alt> key and by installing the Vim plugin: [vim-fixkey](https://github.com/drmikehenry/vim-fixkey).

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
