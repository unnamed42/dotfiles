 " vim-nerdtree
nnoremap <silent> <F1> :NERDTreeToggle<CR>
let NERDTreeNaturalSort=1
let NERDTreeMouseMode=3
let NERDTreeMinimalUI=1
let NERDTreeChDirMode=2
" open a NERDTree automatically when vim starts up
"autocmd vimenter * NERDTree
" open a NERDTree automatically when vim starts up if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
