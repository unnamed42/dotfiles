" deoplete
let g:deoplete#enable_at_startup = 0
" lazy initialization
autocmd InsertEnter * call deoplete#enable()
" close preview when completion is done
autocmd CompleteDone * silent! pclose!
let g:deoplete#auto_complete_start_length = 3
" let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
" let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/5.0.1/include/'
let g:deoplete#sources#clang#executable = '/usr/bin/clang'
let g:deoplete#sources#clang#std = {
\  'c': 'c99', 'cpp': 'c++14'
\ }
" let g:deoplete#sources#clang#sort_algo = 'priority'
let g:deoplete#sources#ternjs#timeout = 3
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx', 'vue']
let g:deoplete#sources = {}
let g:deoplete#sources.gitcommit = ['github']
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'
" let g:deoplete#keyword_patterns.gitcommit = '.+'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
let g:deoplete#omni#input_patterns.lua = '\w+|[^. *\t][.:]\w*'
" call deoplete#util#set_pattern(g:deoplete#omni#input_patterns, 'gitcommit', [g:deoplete#keyword_patterns.gitcommit])
" call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])

