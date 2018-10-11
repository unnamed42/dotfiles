" for :GuiFont in neovim
Plug 'equalsraf/neovim-gui-shim', Cond(has('nvim'))
Plug 'roxma/nvim-yarp', Cond(!has('nvim'))
Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))

Plug 'troydm/easytree.vim', {'on': 'EasyTreeToggle'}
Plug 'KeitaNakamura/tex-conceal.vim'

Plug 'huawenyu/neogdb.vim'
Plug 'SevereOverfl0w/deoplete-github'
Plug 'fszymanski/deoplete-emoji'
Plug 'davidhalter/jedi', {'for': ['python']}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'jeaye/color_coded', {'for': g:c_family_lang}
Plug 'arakashic/chromatica.nvim'
Plug 'tenfyzhong/CompleteParameter.vim'

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'ervandew/supertab'

Plug 'lambdalisue/suda.vim'

Plug 'prabirshrestha/vim-lsp'

Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-clang'
Plug 'roxma/ncm-github'
Plug 'calebeby/ncm-css'
Plug 'roxma/nvim-cm-tern'

" Load after ctrlp,nerdtree,airline
Plug 'ryanoasis/vim-devicons'

Plug 'zchee/deoplete-clang'
Plug 'tweekmonster/deoplete-clang2'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'keremc/asyncomplete-clang.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'
Plug 'prabirshrestha/asyncomplete-flow.vim'

Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'Shougo/neoinclude.vim'
" Completion framework
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-zsh'
Plug 'carlitux/deoplete-ternjs'
