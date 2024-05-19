call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'RRethy/vim-illuminate'
  Plug 'sainnhe/edge'
  Plug 'sainnhe/sonokai'
  Plug 'sainnhe/everforest'
  Plug 'sainnhe/gruvbox-material'
  Plug 'ryanoasis/vim-devicons'
  Plug 'luochen1990/rainbow'
  Plug 'itchyny/lightline.vim'
  Plug 'ervandew/supertab'
  Plug 'mhinz/vim-signify'
  Plug 'Yggdroot/indentLine'
  Plug 'mattn/emmet-vim'
  Plug 'andymass/vim-matchup'
  Plug 'jiangmiao/auto-pairs'
  Plug 'alvan/vim-closetag'
  Plug 'tpope/vim-surround'
  Plug 'AndrewRadev/tagalong.vim'
  Plug 'Pocco81/auto-save.nvim'
  Plug 'junegunn/fzf.vim'
  Plug 'coreyja/fzf.devicon.vim'
  Plug 'junegunn/fzf', {
        \'do': { -> fzf#install() }
        \}
  Plug 'neoclide/coc.nvim', {
        \'branch': 'master', 
        \'do': 'yarn install --frozen-lockfile'
        \}
call plug#end()

" Neovim settings
source ~/.config/nvim/neovim_settings.vim

" Plugins settings
source ~/.config/nvim/plugins_settings.vim

" Theme settings
source ~/.config/nvim/themes/sonokai_theme.vim
