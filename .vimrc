" Admin
set nocompatible              " required
filetype off                  " required
set noswapfile
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" Prevent locale error message for Ack
language en_US.UTF-8
" let Vundle manage Vundle, required
call vundle#begin()

" Plugins with Vundle
Plugin 'gmarik/Vundle.vim'
" General
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
" Themes
Plugin 'morhetz/gruvbox'
" File managers
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
" Front-End
Plugin 'Valloric/MatchTagAlways'
Plugin 'mxw/vim-jsx'
Plugin 'slim-template/vim-slim.git'
Plugin 'HerringtonDarkholme/yats.vim'
" Python
Plugin 'vim-scripts/indentpython.vim'
Plugin 'hdima/python-syntax'
" Latex
Plugin 'lervag/vimtex' "Latexmk required | Make sure content present before autocompile


" All of your Plugins must be added before the following line
call vundle#end()            " required

" Colorscheme and highlighting
set background=dark
colorscheme gruvbox
highlight htmlTagName cterm=NONE ctermfg=red

" Syntax/Folding/Autocommenting
set number
filetype plugin indent on    " required
syntax on
syntax enable
" Remove auto-commenting
autocmd BufNewFile,BufRead * setlocal formatoptions-=r
" Save folds
augroup remember_folds
	autocmd!
	autocmd BufWinLeave *.* mkview
	autocmd BufWinEnter *.* loadview
augroup END

" Remappings
" Leader
let mapleader = " "
" Autoindentation
map <leader>ai mzgg=G`z
" <Esc> key remap in insert mode
:imap fd <Esc>
" Save
noremap <silent> <leader>fs <C-S>:update<CR>
vnoremap <silent> <leader>fs <C-S><C-C>:update<CR>
" Pasting from yank register
nnoremap <leader>p "0p
" Folds
nnoremap <space> za
vnoremap <space> zf
" Emacs :P
inoremap <C-A> <Esc>I
inoremap <C-E> <Esc>A
cnoremap <C-A> <home>
cnoremap <C-E> <end>
cnoremap <C-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>
" Remapping switch between panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab spacing
set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4 shiftwidth=4 textwidth=79 autoindent
au BufNewFile,BufRead *.php set softtabstop=4 shiftwidth=4 textwidth=79 autoindent
au BufNewFile,BufRead *.js,*.jsx set expandtab tabstop=2 autoindent shiftwidth=2 autoindent
au BufNewFile,BufRead *.css,*.scss set expandtab tabstop=2 autoindent shiftwidth=2 autoindent
au BufNewFile,BufRead *.html set expandtab tabstop=2 autoindent shiftwidth=2 autoindent
au BufNewFile,BufRead *.slim set expandtab tabstop=2 autoindent shiftwidth=2 autoindent

" File Navigation Settings: Ack/Nerdtree/CtrlP
" Ack remapping
map <leader>ff :Ack<space>-i<space>
" Nerdtree remapping
nmap <silent> <C-N> :NERDTreeToggle<CR>
" Ctrlp Customization
let g:ctrlp_map = '<c-p>'
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
						\ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
						\ 'file': '\.so$\|\.dat$|\.DS_Store$'
						\ }
" Set CtrlP working directory to follow vim current directory
let g:ctrlp_working_path_mode = 0

" Make highlighted search result appear in the middle of the screen
:nnoremap n nzz
:nnoremap N Nzz
set hlsearch


" Disable quickfixline highlighting
highlight! link QuickFixLine Normal

" Warn for whitespace and clear whitespace
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z


inoremap <C-B> <ESC>YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<esc>ko
