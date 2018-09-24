" who needs vi?
set nocompatible

set encoding=utf-8 ffs=unix,dos,mac

set background=dark

" pyx version, for compatibilities
" set pyxversion=3

" neovim changes terminal cursor shape, disable this behaviour
set guicursor=

set guioptions+=M

" automatic filetype determination
filetype indent plugin on
" enable syntax highlight
syntax on

" list trailing whitespaces
set list listchars=tab:»·,trail:·
" remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

" clipboard = X CLIPBOARD buffer
set clipboard=unnamedplus

set lazyredraw

" faster scrolling
set ttyfast

set hidden

" disable backups
set nobackup nowb

" set undo histories
set undofile undodir=/tmp

set title

" Better line wrapping
set wrap linebreak
set formatoptions+=qrn1

" enable mouse support
set mouse=a

" Set to auto read when a file is changed from the outside
set autoread

" Display the cursor position
set ruler

" statusline plugins integration
set laststatus=2 noshowmode

" Disable belling
set noerrorbells novisualbell

" Removing scrollbars in gvim
if has("gui_running")
    set guitablabel=%-0.12t%M
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions+=a
    set guioptions-=m
else
    set t_Co=256 termguicolors
endif

" Better command-line completion
set wildmenu wildmode=longest,list,full
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Show partial commands in the last line of the screen
set showcmd

" Set the command window height to 2 line
set cmdheight=2

" Highlight searches, incremental search
set hlsearch incsearch

" offsets of centering search result
set scrolloff=7

" Regex magic
set magic

" Show matching brackets when cursor over
set showmatch mat=2

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" enable line number
set number relativenumber
" auto toggle relative number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" margin left
set foldcolumn=1

" conceal modes

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent smartindent

" Allow text fold
set fdm=syntax nofoldenable

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" can navigate past the end
set virtualedit=onemore

" New split window mode
set splitright splitbelow

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" set to first line when editing git commit
autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" tab options: tab to space, ident 4
set expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4

" move to next/previous lines automatically
set whichwrap+=<,>,h,l,[,]

" set vim's working directory to current file
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" quickfix window auto adjust
au FileType qf call AdjustWindowHeight(3, 10)
" set quickfix window to bottom
autocmd FileType qf wincmd J
" close quickfix when leaving file
au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif

" start vim in insert mode
"autocmd BufRead,BufNewFile * startinsert

set completeopt=longest

set shortmess=asIc
