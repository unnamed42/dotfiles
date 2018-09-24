" nvim-completion-manager
let g:cm_complete_popup_delay = 200
let g:cm_completed_snippet_enable = 1
let g:cm_completed_snippet_engine = 'ultisnips'
autocmd BufEnter *.cpp,*.h,*.hpp,*.hxx let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'], ' ')
