" Name:        hjklmode.vim
" Description: Learn Hjkl navigation!
"
" Maintainer:  James Cherti
" URL:         https://github.com/jamescherti/vim-hjklmode
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

let s:hjklmode_enabled = -1
let s:hjklmode_key_mappings = []

function! hjklmode#Enable()
  let l:enabled = 1
  let l:buffer_only = 0
  call s:HjklmodeSetStatus(l:enabled, l:buffer_only)
endfunction

function! hjklmode#Disable()
  let l:enabled = 0
  let l:buffer_only = 0
  call s:HjklmodeSetStatus(l:enabled, l:buffer_only)
endfunction

function! hjklmode#IsEnabled()
  if s:hjklmode_enabled <= 0
    let l:is_enabled = 0
  else
    let l:is_enabled = 1
  endif
  return l:is_enabled
endfunction

function! hjklmode#Toggle()
  if hjklmode#IsEnabled()
    call hjklmode#Disable()
  else
    call hjklmode#Enable()
  endif
endfunction

function! s:HjklmodeSetStatus(enabled, buffer_only) abort
  if s:hjklmode_enabled >= 0 && s:hjklmode_enabled ==# a:enabled ? 1 : 0
    return
  endif
  let s:hjklmode_enabled = a:enabled ? 1 : 0

  if exists('s:hjklmode_key_mappings')
    let l:key_mappings = hjklmode#GetKeyMappings()
  else
    let l:key_mappings = []
  endif

  for l:item in l:key_mappings
    call s:MapSetStatus(
      \  a:enabled,
      \  a:buffer_only,
      \  l:item['mapping_mode'],
      \  l:item['key_sequence1'],
      \  l:item['key_sequence2']
      \)
  endfor
endfunction

function! hjklmode#GetKeyMappings() abort
  call hjklmode#Init()
  let result = []
  for l:key_mappings_item in s:hjklmode_key_mappings
    for l:mapping_mode in l:key_mappings_item[2]
      for l:key_sequence1 in l:key_mappings_item[0]
        let l:key_sequence2 = l:key_mappings_item[1]
        call add(result, {'mapping_mode': l:mapping_mode, 'key_sequence1': l:key_sequence1, 'key_sequence2': l:key_sequence2})
      endfor
    endfor
  endfor
  return result
endfunction

function! s:MapSetStatus(enabled, buffer_only, mapping_mode, key_sequence1, key_sequence2) abort
  let l:mapping_cmd_name = a:enabled ? 'noremap' : 'unmap'
  if a:buffer_only
    let l:mapping_cmd_name .= ' <buffer>'
  endif

  let l:mapping_cmd = ''
  if a:enabled
    let l:mapping_cmd = a:mapping_mode . l:mapping_cmd_name . ' ' . a:key_sequence1 . ' ' . a:key_sequence2
  else
    if !empty(maparg(a:key_sequence1, a:mapping_mode))
      let l:mapping_cmd = a:mapping_mode . l:mapping_cmd_name . l:mapping_cmd . ' ' . a:key_sequence1
    endif
  endif

  if l:mapping_cmd !=# ''
    try
      execute 'silent! ' . l:mapping_cmd
    catch
      echomsg 'hjklmode: mapping error: ' . l:mapping_cmd
    endtry
  endif
endfunction

function! hjklmode#Init() abort
  let l:all_modes = ['n', 'i', 'v', 't', 's', 'c']

  let l:key_mappings = []

  call add(l:key_mappings, [['<A-h>'], '<Left>', ['i']])
  call add(l:key_mappings, [['<expr> <A-j>'], 'pumvisible() ? "<C-n>" : "<Down>"', ['i']])
  call add(l:key_mappings, [['<expr> <A-k>'], 'pumvisible() ? "<C-p>" : "<Up>"', ['i']])
  call add(l:key_mappings, [['<A-l>'], '<Right>', ['i']])

  call add(l:key_mappings, [['<A-h>'], '<Left>', ['c', 't']])
  call add(l:key_mappings, [['<A-j>'], '<Down>', ['c', 't']])
  call add(l:key_mappings, [['<A-k>'], '<Up>', ['c', 't']])
  call add(l:key_mappings, [['<A-l>'], '<Right>', ['c', 't']])

  " Escape and Backspace
  if has('gui_running') && !has('win32')
    " Only when gui_running because Escape/Ctrl-[ are the same characters when
    " Vim is executed in a terminal or on Microsoft Windows.
    call add(l:key_mappings, [['<C-[>'], '<Esc>', ['n', 'i', 'v', 't', 's']])
    call add(l:key_mappings, [['<C-[>'], '<C-c>', ['c']])
    call add(l:key_mappings, [['<Esc>'], '<Nop>', l:all_modes])
  endif

  call add(l:key_mappings, [['<Backspace>'] , '<Nop>', l:all_modes])

  " Disable mappings
  call add(l:key_mappings, [['<PageUp>', '<PageDown>', '<Home>', '<Insert>', '<End>', '<Delete>'] , '<Nop>', l:all_modes])
  call add(l:key_mappings, [['<Up>', '<Down>', '<Left>', '<Right>'], '<Nop>', ['n', 'v']])

  if has('gui_running')
    " Because the key mappings <Alt> + hjkl do not work when Vim is executed
    " in a terminal.
    call add(l:key_mappings, [['<Up>', '<Down>', '<Left>', '<Right>'], '<Nop>', ['i', 't', 's', 'c']])
  endif

  call add(l:key_mappings, [['<Up>', '<Down>', '<Left>', '<Right>'], '<Nop>', ['n', 'v']])
  call add(l:key_mappings, [['+', '-'], '<Nop>', ['n']])

  let s:hjklmode_key_mappings = l:key_mappings
  return s:hjklmode_key_mappings
endfunction
