au User asyncomplete_setup call asyncomplete#register_source(
  \ asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
  \ })
\)

au User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd']},
    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })

" autocmd User asyncomplete_setup call asyncomplete#register_source(
"     \ asyncomplete#sources#clang#get_source_options({
"     \     'config': {
"     \         'clang_args': {
"     \             'default': ['-I/usr/include', '-std=c++14'],
"     \             'cpp': ['-std=c++14', g:cpp_stdlib_path]
"     \         }
"     \     }
"     \ }))
au User asyncomplete_setup call asyncomplete#register_source(
  \ asyncomplete#sources#omni#get_source_options({
    \ 'name': 'omni',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['html'],
    \ 'completor': function('asyncomplete#sources#omni#completor')
    \ })
  \)

au User asyncomplete_setup call asyncomplete#register_source(
  \ asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ })
  \ )

au User asyncomplete_setup call asyncomplete#register_source(
  \ asyncomplete#sources#necosyntax#get_source_options({
    \ 'name': 'necosyntax',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
    \ })
  \ )

au User asyncomplete_setup call asyncomplete#register_source(
  \ asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'whitelist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ })
  \ )

au User asyncomplete_setup call asyncomplete#register_source(
  \ asyncomplete#sources#flow#get_source_options({
    \ 'name': 'flow',
    \ 'whitelist': ['javascript'],
    \ 'completor': function('asyncomplete#sources#flow#completor'),
    \ 'config': {
    \    'prefer_local': 1,
    \    'flowbin_path': expand('~/bin/flow'),
    \  },
    \ })
  \ )

au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'vimtex',
    \ 'whitelist': ['tex'],
    \ 'completor': function('vimtex#complete#omnifunc'),
    \ })
