" YouCompleteMe
autocmd FileType vim setlocal omnifunc=OmnicompleteVimscript
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
let g:ycm_python_binary_path = 'python'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_conf.py'
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_complete_in_comments = 1
let g:ycm_error_symbol = '!!'
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_key_detailed_diagnostics = '<Leader>dd'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_stop_completion = ['<C-y>', '<C-c>']
let g:ycm_filetype_specific_completion_to_disable = {
\ 'gitcommit': 1
\}
let g:ycm_filetype_blacklist = {
\ 'tagbar' : 1,
\ 'qf' : 1,
\ 'notes' : 1,
\ 'markdown' : 1,
\ 'unite' : 1,
\ 'text' : 1,
\ 'vimwiki' : 1,
\ 'pandoc' : 1,
\ 'infolog' : 1,
\ 'mail' : 1
\}
