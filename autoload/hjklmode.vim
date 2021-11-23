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
  \                     '<PageDown>', '<Home>', '<Insert>', '<End>',
  \                     '<Delete>', '<Backspace>']

  if has('gui_running')
    " Terminal emulators receive the character <Ctrl-[> when the user presses
    " <Esc>. That is why <Esc> can only be disabled in GUI mode.
    call add(l:disable_keys, '<Esc>')

    " Map <C-[> to <Esc> (it has to be done before <Esc> is mapped to <Nop>).
    for l:mapping_mode in ['n', 'i', 'v', 't', 's']
      call s:MapSetStatus(a:enabled, a:buffer_only, l:mapping_mode, '<C-[>', '<Esc>')
    endfor

    " Special case for command mode
    call s:MapSetStatus(a:enabled, a:buffer_only, 'c', '<C-[>', '<C-c>')
  endif

  " Disable keys
  call s:MapSetStatus(a:enabled, a:buffer_only, 'n', '+', '<Nop>')
  call s:MapSetStatus(a:enabled, a:buffer_only, 'n', '-', '<Nop>')

  for l:mapping_mode in ['n', 'i', 'v', 't', 's', 'c']
    for l:key in l:disable_keys
      call s:MapSetStatus(a:enabled, a:buffer_only, l:mapping_mode, l:key, '<Esc>')
    endfor
  endfor

  " Add <Alt> + "hjkl" navigation to Insert Mode, Command Mode and Terminal Mode
  call s:MapSetStatus(a:enabled, a:buffer_only, 'i', '<A-h>', '<Left>')
  call s:MapSetStatus(a:enabled, a:buffer_only, 'i', '<expr> <A-j>', 'pumvisible() ? "<C-n>" : "<Down>"')
  call s:MapSetStatus(a:enabled, a:buffer_only, 'i', '<expr> <A-k>', 'pumvisible() ? "<C-p>" : "<Up>"')
  call s:MapSetStatus(a:enabled, a:buffer_only, 'i', '<A-l>', '<Right>')

  for l:mapping_mode in ['c', 't']
    for l:key_mapping in [['<A-h>', '<Left>'], ['<A-j>', '<Down>'], ['<A-k>', '<Up>'], ['<A-l>', '<Right>']]
      call s:MapSetStatus(a:enabled, a:buffer_only, l:mapping_mode, l:key_mapping[0], l:key_mapping[1])
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

function! hjklmode#Switch()
  if hjklmode#IsEnabled()
    call hjklmode#Disable()
  else
    call hjklmode#Enable()
  endif
endfunction
