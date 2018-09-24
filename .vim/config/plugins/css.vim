" vim-css3-syntax
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END
highlight VendorPrefix guifg=#00ffff gui=bold
match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/

" scss-syntax.vim
au BufRead,BufNewFile *.scss set filetype=scss.css
autocmd FileType scss set iskeyword+=-
