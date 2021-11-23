" Name:        hjklmode.vim
" Description: Hjkl navigation in all Vim modes.
"
" Maintainer:  James Cherti
" URL:         https://github.com/jamescherti/hjklmode.vim
"
" Licence:     Copyright (c) James Cherti
"              Distributed under terms of the MIT license.
"
"              Permission is hereby granted, free of charge, to any person
"              obtaining a copy of this software and associated documentation
"              files (the 'Software'), to deal in the Software without
"              restriction, including without limitation the rights to use,
"              copy, modify, merge, publish, distribute, sublicense, and/or
"              sell copies of the Software, and to permit persons to whom the
"              Software is furnished to do so, subject to the following
"              conditions: The above copyright notice and this permission
"              notice shall be included in all copies or substantial portions
"              of the Software. THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT
"              WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
"              LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
"              PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
"              AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
"              OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
"              OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"              SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

function! hjklmode#Enable()
  let l:disable_keys = ['<Up>', '<Down>', '<Left>', '<Right>', '<PageUp>',
  \                     '<PageDown>', '<Home>', '<Insert>', '<End>',
  \                     '<Delete>', '<Backspace>']

  " Terminal emulators receive the character <Ctrl-[> when the user presses
  " <Esc>. That is why <Esc> can only be disabled in GUI mode.
  if has('gui_running')
    call add(l:disable_keys, '<Esc>')

    " Map <C-[> to <Esc> (it has to be done before <Esc> is mapped to <Nop>).
    for mapping_mode in ['n', 'i', 'v', 't', 's']
      execute mapping_mode . 'noremap <C-[> <Esc>'
    endfor

    " Special case for command mode
    cnoremap <C-[> <C-c>
  endif

  " Disable keys
  nnoremap + <Nop>
  nnoremap - <Nop>
  for l:mapping_mode in ['n', 'i', 'v', 't', 's', 'c']
    for l:key in l:disable_keys
      execute l:mapping_mode . 'noremap ' . l:key . ' <Nop>'
    endfor
  endfor

  " Add <Alt> + "hjkl" navigation to Insert Mode, Command Mode and Terminal Mode
  inoremap <A-h> <Left>
  inoremap <expr> <A-j> pumvisible() ? '<C-n>' : '<Down>'
  inoremap <expr> <A-k> pumvisible() ? '<C-p>' : '<Up>'
  inoremap <A-l> <Right>
  for l:mapping_mode in ['c', 't']
    for l:key_mapping in ['<A-h> <Left>', '<A-j> <Down>', '<A-k> <Up>', '<A-l> <Right>']
      execute l:mapping_mode . 'noremap ' . l:key_mapping
    endfor
  endfor
endfunction
