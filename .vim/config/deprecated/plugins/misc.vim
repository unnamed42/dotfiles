" dirvish
let g:loaded_netrwPlugin = 1 " supress netrw
let g:dirvish_mode = ':sort ,^.*[\/],'
autocmd FileType dirvish silent keeppatterns g@\v/\.[^\/]+/?$@d _

" jellybeans.vim
let g:jellybeans_use_term_italics = 1

" minisnip
let g:minisnip_dir = $HOME.'/.vim/snippets'
let g:minisnip_trigger = '<C-j>'

" tex-conceal.vim
set conceallevel=2
let g:tex_conceal="abdgm"

" color_coded
if &diff
    let g:color_coded_enabled = 0
else
    let g:color_coded_enabled = 1
endif
let g:color_coded_filetypes = CFamilyLang

