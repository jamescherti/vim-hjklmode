silent! HjklmodeDisable
silent! HjklmodeEnable

for s:key_mapping in hjklmode#get_key_mappings()
  let key_sequence1 = trim(substitute(tolower(s:key_mapping['key_sequence1']), '<expr>', '', 'g'))
  let key_sequence1 = tolower(trim(maparg(key_sequence1, s:key_mapping['mapping_mode'])))
  let key_sequence2 = tolower(s:key_mapping['key_sequence2'])

  if key_sequence1 != key_sequence2
    echomsg 'ERROR: '. s:key_mapping['mapping_mode'] . ': "' . key_sequence1 . '" != "' . key_sequence2 . '"'
    finish
  endif
endfor

echo "Success."
