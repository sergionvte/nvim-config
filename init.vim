call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'sainnhe/gruvbox-material'
  Plug 'ryanoasis/vim-devicons'
  Plug 'luochen1990/rainbow'
  Plug 'itchyny/lightline.vim'
  "Plug 'ap/vim-buftabline'
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
  Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
call plug#end()

" Neovim settings
source ~/.config/nvim/neovim_settings.vim

" Plugins settings
source ~/.config/nvim/plugins_settings.vim
