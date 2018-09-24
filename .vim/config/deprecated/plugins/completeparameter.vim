" CompleteParameter.vim
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
let g:complete_parameter_use_ultisnips_mappings = 1
let g:complete_parameter_py_keep_value = 0
" auto-pairs coop workaround
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <expr><silent> ) AutoPairsInsert(')')
