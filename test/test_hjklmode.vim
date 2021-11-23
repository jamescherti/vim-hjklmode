silent! HjklmodeDisable
silent! HjklmodeEnable

let disable_keys = ['<Up>', '<Down>', '<Left>', '<Right>', '<PageUp>',
  \                   '<PageDown>', '<Home>', '<Insert>', '<End>',
  \                   '<Delete>', '<Backspace>']
let key_mappings = [
  \  [['<C-[>'], '<Esc>', ['n', 'i', 'v', 't', 's']],
  \  [['<C-[>'], '<C-c>', ['c']],
  \
  \  [disable_keys, '<Nop>', ['n', 'i', 'v', 't', 's', 'c']],
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

for key_mappings_item in key_mappings
  for mapping_mode in key_mappings_item[2]
    for key_sequence1 in key_mappings_item[0]
      let key_sequence1 = tolower(key_sequence1)
      let key_sequence1 = substitute(key_sequence1, '<expr>', '', 'g')
      let key_sequence1 = trim(key_sequence1)
      let key_sequence1 = tolower(trim(maparg(key_sequence1, mapping_mode)))

      let key_sequence2 = tolower(key_mappings_item[1])

      if key_sequence1 != key_sequence2
        echomsg 'ERROR: '. mapping_mode . ': "' . key_sequence1 . '" != "' . key_sequence2 . '"'
        finish
      endif
    endfor
  endfor
endfor

echo "Success."
