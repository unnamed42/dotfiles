let mapleader=' '

" easier to type
nnoremap ; :
vnoremap ; :

" change Esc to Ctrl-C
" mapping over <Esc> can cause an issue in terminal vim where arrow keys will print letters A through D along with a newline rather than moving.
map <C-c> <Esc>

" edit config file
nnoremap <expr> <Leader>ec ':edit '.g:config_path

" resizing
nnoremap <Leader>rs :resize<Space>
nnoremap <Leader>rv :vertical<Space>resize<Space>

" location-list open/close
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>lc :lclose<CR>
" location-list next/previous
nnoremap <silent> <Leader>lj :lnext<CR>
nnoremap <silent> <Leader>lk :lprevious<CR>

" toggle tagbar
" nnoremap <silent> tb :TagbarToggle<CR>

" refresh syntax highlight
nnoremap <silent> <Leader>sr :syntax off<CR>:syntax on<CR>

" open file tree
nnoremap <silent> <F1> :NERDTreeToggle<CR>

" close buffer
nnoremap <silent> <Leader>q :bd<CR>
nnoremap <silent> <Leader>Q :bd!<CR>
nnoremap <silent> <Leader>wq :w<Bar>bd<CR>

" buffer switching
noremap <silent> <Leader>bh :bprevious<CR>
noremap <silent> <Leader>bl :bnext<CR>
nnoremap <silent> <Leader>bb :ToggleBufExplorer<CR>

" tab switching
nnoremap <silent> th :tabprevious<CR>
nnoremap <silent> tl :tabnext<CR>

" <Ctrl-C> == quit completion
" inoremap <expr> <C-c> pumvisible() ? "\<C-e>" : "\<Esc>"
" <CR> close popup, confirm selection
" inoremap <expr> <silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" prevent cursor move backward
" inoremap <silent> <Esc> <C-O>:stopinsert<CR>

" move through displayed lines
" imap <silent> <Down> <C-o>gj
" imap <silent> <Up> <C-o>gk

" insert new line in normal mode
nmap <silent> , :put!_<CR>
" < is shift+,
nmap <silent> < :put_<CR>

" Ctrl+A == select all
nmap <silent> <C-a> ggvG$

" Ctrl+Shift+Up == move line/selection up
imap <silent> <C-S-Up> <Esc>:m .-2<CR>==gi
nmap <silent> <C-S-Up> :m .-2<CR>==
vmap <silent> <C-S-Up> :m '<-2<CR>gv=gv

" Ctrl+Shift+Down == move line/selection down
imap <silent> <C-S-Down> <Esc>:m .+1<CR>==gi
nmap <silent> <C-S-Down> :m .+1<CR>==
vmap <silent> <C-S-Down> :m '>+1<CR>gv=gv

" Ctrl+Direction == switch to split in direction
nmap <silent> <C-Up> <C-W>k
nmap <silent> <C-Down> <C-W>j
nmap <silent> <C-Left> <C-W>h
nmap <silent> <C-Right> <C-W>l

" Ctrl-Z == undo
inoremap <silent> <C-z> <C-o>u
nnoremap <silent> <C-z> :u<CR>

" Ctrl-R == redo
inoremap <silent> <C-r> <C-o><C-r>

" Ctrl+T == newtab
nnoremap <silent> <C-t> :tabe<CR>

" Ctrl+F == clear search result highlight
noremap <silent> <C-f> <Esc>:noh<CR>

" Ctrl+D == toggle comment
imap <silent> <C-d> <C-o>gc$
nmap <silent> <C-d> ^gc$
vmap <silent> <C-d> gc

" Ctrl+Backspace == delete to previous word
inoremap <silent> <C-Backspace> <C-o>db

" Ctrl+Del == delete to next word
inoremap <silent> <C-Del> <C-o>de
