call plug#begin('~/.vim/plugged')

" Display
Plug 'tomasr/molokai'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-buftabline'

" Editing
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'

" Tools
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'}
Plug 'jlanzarotta/bufexplorer'
Plug 'yegappan/mru'
Plug 'jceb/vim-orgmode'
Plug 'Chiel92/vim-autoformat'

" Highlighting
Plug 'bfrg/vim-cpp-modern'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'nikvdp/ejs-syntax'
Plug 'wavded/vim-stylus'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tbastos/vim-lua'

" Completion
Plug 'richq/vim-cmake-completion'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neoinclude.vim'
" Completion framework
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'
Plug 'tweekmonster/deoplete-clang2'
Plug 'zchee/deoplete-zsh'
Plug 'carlitux/deoplete-ternjs'

" Coding
Plug 'lervag/vimtex'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

for config in split(globpath(g:config_path.'plugins', '*.vim'), '\n')
  execute 'source' config
endfor
