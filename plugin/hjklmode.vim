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

if exists("loaded_hjklmode")
  finish
endif
let g:loaded_hjklmode = 1

if ! exists('g:hjklmode_enabled')
  let g:hjklmode_enabled = 0
endif

command! -nargs=0 HjklmodeStatus echo hjklmode#IsEnabled() ? 'Enabled' : 'Disabled'

command! -nargs=0 HjklmodeToggle call hjklmode#Toggle() | HjklmodeStatus

command! -nargs=0 HjklmodeEnable call hjklmode#Enable() | HjklmodeStatus
command! -nargs=0 HjklmodeDisable call hjklmode#Disable() | HjklmodeStatus

if g:hjklmode_enabled
  call hjklmode#Enable()
endif
