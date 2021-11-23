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

let s:hjklmode_enabled = -1

function! s:MapSetStatus(enable, buffer_only, mapping_mode, key_sequence1, key_sequence2) abort
  let l:mapping_cmd_name = a:enable ? 'noremap' : 'unmap'
  if a:buffer_only
    let l:mapping_cmd_name .= ' <buffer>'
  endif

  let l:mapping_cmd = ''
  if a:enable
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

function! s:HjklmodeSetStatus(enabled, buffer_only) abort
  if s:hjklmode_enabled >= 0 && s:hjklmode_enabled ==# a:enabled ? 1 : 0
    return
  endif
  let s:hjklmode_enabled = a:enabled ? 1 : 0

  " The keys that should be disabled when hjklmode is enabled
  let l:disable_keys = ['<Up>', '<Down>', '<Left>', '<Right>', '<PageUp>',
    \                   '<PageDown>', '<Home>', '<Insert>', '<End>',
    \                   '<Delete>', '<Backspace>']
  if has('gui_running')
    " Terminal emulators receive the character <Ctrl-[> when the user presses
    " <Esc>. That is why <Esc> can only be disabled in GUI mode.
    call add(l:disable_keys, '<Esc>')
  endif

  let l:key_mappings = [
    \  [['<C-[>'], '<Esc>', ['n', 'i', 'v', 't', 's']],
    \  [['<C-[>'], '<C-c>', ['c']],
    \
    \  [l:disable_keys, '<Nop>', ['n', 'i', 'v', 't', 's', 'c']],
    \  [['+', '-'], '<Nop>', ['n']],
    \
    \  [['<A-h>'], '<Left>', ['i']],
    \  [['<expr> <A-j>'], 'pumvisible() ? "<C-n>" : "<Down>"', ['i']],
    \  [['<expr> <A-k>'], 'pumvisible() ? "<C-p>" : "<Up>"', ['i']],
    \  [['<A-l>'], '<Right>', ['i']],
    \
    \  [['<A-h>'], '<Left>', ['c', 't']],
    \  [['<A-j>'], '<Down>', ['c', 't']],
    \  [['<A-k>'], '<Up>', ['c', 't']],
    \  [['<A-l>'], '<Right>', ['c', 't']]
    \]

  for l:key_mappings_item in l:key_mappings
    for l:mapping_mode in l:key_mappings_item[2]
      for l:key_sequence1 in l:key_mappings_item[0]
        let l:key_sequence2 = l:key_mappings_item[1]
        call s:MapSetStatus(
          \  a:enabled,
          \  a:buffer_only,
          \  l:mapping_mode,
          \  l:key_sequence1,
          \  l:key_sequence2
          \)
      endfor
    endfor
  endfor
endfunction

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
  return s:hjklmode_enabled
endfunction

function! hjklmode#Toggle()
  if hjklmode#IsEnabled()
    call hjklmode#Disable()
  else
    call hjklmode#Enable()
  endif
endfunction
