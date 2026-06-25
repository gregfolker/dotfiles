" Basic configuration file for vim
" http://nvie.com/posts/how-i-boosted-my-vim/

" Use Vim defaults instead of trying to be 100% compatible with vi.
" This must be first, because it changes other options as side effect.
set nocompatible
set encoding=utf-8

" Enable filetype detection by vim
filetype on
filetype plugin on

" Indentation rules are based on the syntax rules for the detected filetype
filetype plugin indent on

if has("syntax") && (&t_Co > 2 || has("gui_running"))
    " Basic syntax highlighting
    syntax on
endif

" Autocomplete menu for commands that you can <tab> through
set wildmenu

" Change the leader key from \ to ,
let mapleader=","

" Disable swap file and backup generation
set noswapfile
set nobackup
set nowritebackup

" Automatically reload files modified outside of vim
set autoread

" Do not wrap lines
set nowrap

" Display tabs as four spaces (Default is six)
set tabstop=4

" When backspacing, pretend like a tab is removed even if it is a space
set softtabstop=4

" Expand tabs to spaces by default
set expandtab

" Always use autoindenting and copy the previous indentation
set autoindent
set copyindent

" Number of spaces to use for autoindent
set shiftwidth=4

" Use a multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" Do not show invisible characters by default
set nolist

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Always show the cursor position
set ruler

" Highlight search results by default
set hlsearch

" Move cursor to search matches as they are typed
set incsearch

" Ignore case when search pattern is all lowercase, otherwise use
" case-sensitive search
set smartcase

" Highlight matching parenthesis
set showmatch

" Always show line numbers
set number

" Remember all the things!
set history=1000

" Allow for many uh-ohs
set undolevels=1000

" Quickly edit/reload ~/.vimrc
nnoremap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <silent> <leader>sv :so $MYVIMRC<cr>

" Automatically insert a \v before any string that is searched to turn off
" Vim's flavor of regex characters.
" https://stevelosh.com/blog/2010/09/coming-home-to-vim/#s10-making-vim-more-useful
nnoremap / /\v
vnoremap / /\v

" Easily get rid of the distracting highlighting after searching
nnoremap <leader><space> :nohlsearch<cr>

" Make j and k move by file line instead of screen line. Useful
" when line wrapping is enabled
nnoremap j gj
nnoremap k gk

" Make ; do the same thing as : because it's one less key to hit
nnoremap ; :

" Make ,W strip all trailing white space in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" Make window navigation easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make H and L go to the start and end of the current line, respectively
noremap H ^
noremap L $

" Make jk exit insert mode instead of <esc>
inoremap jk <esc>

" Use <tab> to jump to a matching bracket instead of %
nnoremap <tab> %
vnoremap <tab> %

" Make :w!! write files opened that require sudo permissions
cnoremap w!! w !sudo tee % >/dev/null
