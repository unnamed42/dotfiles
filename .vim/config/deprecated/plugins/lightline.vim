" lightline.vim
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' },
\ 'active': {
\   'left': [ ['mode', 'paste'],
\             ['gitbranch', 'readonly', 'filename'] ]
\ },
\ 'component_function': {
\   'gitbranch': 'StatusLineFugitive',
\   'readonly': 'StatusLineReadOnly',
\   'filename': 'StatusLineFilename',
\ },
\}
