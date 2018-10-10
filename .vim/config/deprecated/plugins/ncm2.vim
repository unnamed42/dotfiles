" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" au User Ncm2Plugin call ncm2#register_source({
"         \ 'name' : 'css',
"         \ 'priority': 9,
"         \ 'subscope_enable': 1,
"         \ 'scope': ['css','scss'],
"         \ 'mark': 'css',
"         \ 'word_pattern': '[\w\-]+',
"         \ 'complete_pattern': ':\s*',
"         \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
"         \ })

" au Filetype tex call ncm2#register_source({
"     \ 'name' : 'vimtex-cmds',
"     \ 'priority': 8,
"     \ 'complete_length': -1,
"     \ 'scope': ['tex'],
"     \ 'matcher': {'name': 'prefix', 'key': 'word'},
"     \ 'word_pattern': '\w+',
"     \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
"     \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"     \ })
" au Filetype tex call ncm2#register_source({
"     \ 'name' : 'vimtex-labels',
"     \ 'priority': 8,
"     \ 'complete_length': -1,
"     \ 'scope': ['tex'],
"     \ 'matcher': {'name': 'combine',
"     \             'matchers': [
"     \               {'name': 'substr', 'key': 'word'},
"     \               {'name': 'substr', 'key': 'menu'},
"     \             ]},
"     \ 'word_pattern': '\w+',
"     \ 'complete_pattern': g:vimtex#re#ncm2#labels,
"     \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"     \ })
" au Filetype tex call ncm2#register_source({
"     \ 'name' : 'vimtex-files',
"     \ 'priority': 8,
"     \ 'complete_length': -1,
"     \ 'scope': ['tex'],
"     \ 'matcher': {'name': 'combine',
"     \             'matchers': [
"     \               {'name': 'abbrfuzzy', 'key': 'word'},
"     \               {'name': 'abbrfuzzy', 'key': 'abbr'},
"     \             ]},
"     \ 'word_pattern': '\w+',
"     \ 'complete_pattern': g:vimtex#re#ncm2#files,
"     \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"     \ })
" au Filetype tex call ncm2#register_source({
"     \ 'name' : 'bibtex',
"     \ 'priority': 8,
"     \ 'complete_length': -1,
"     \ 'scope': ['tex'],
"     \ 'matcher': {'name': 'combine',
"     \             'matchers': [
"     \               {'name': 'prefix', 'key': 'word'},
"     \               {'name': 'abbrfuzzy', 'key': 'abbr'},
"     \               {'name': 'abbrfuzzy', 'key': 'menu'},
"     \             ]},
"     \ 'word_pattern': '\w+',
"     \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
"     \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
"     \ })
