" Basic {
set nocompatible
set shell=/bin/zsh

if filereadable(expand("~/.vimrc.init"))
    source ~/.vimrc.init
endif

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif
" }

" Env Setting {
set termguicolors               " Force true color for neovim
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set matchpairs+=<:>             " Match, to be used with %
set lazyredraw                  " redraw only when we need to.

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=5                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

filetype plugin indent on           " Automatically detect file types.
syntax on                           " Syntax highlighting
set mouse=a                         " Automatically enable mouse usage
set mousehide                       " Hide the mouse cursor while typing
scriptencoding utf-8

if has('unnamedplus')               " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
else                                " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif

set autoread                        " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                     " Fix broken backspace in some setups
set directory-=.                    " don't store swapfiles in the current directory
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving

" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" let terminal resize scale the internal windows
autocmd VimResized * :wincmd =
" }

" Vim UI {
set background=dark
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = 1
let g:airline_theme = 'gruvbox'
colorscheme gruvbox
" set t_8f=^[[38;2;%lu;%lu;%lum
" set t_8b=^[[48;2;%lu;%lu;%lum
" let g:neosolarized_contrast = "normal"
" let g:neosolarized_visibility = "normal"
" let g:neosolarized_bold = 1
" let g:neosolarized_underline = 1
" let g:neosolarized_italic = 1
" colorscheme NeoSolarized

set showmode                    " Display the current mode
set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
endif

if has('statusline')
    set laststatus=2
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif
" }

" Key (re)Mappings {
" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
map <Leader>= <C-w>=

" Most prefer to toggle search highlighting rather than clear the current
nmap <silent> <leader>/ :set invhlsearch<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!) http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Some helpers to edit mode http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ow :e %%
map <leader>os :sp %%
map <leader>ov :vsp %%
map <leader>ot :tabe %%

" Easier horizontal scrolling
map zl zL
map zh zH

" Fast tabs
map <S-H> gT
map <S-L> gt

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Fast enter command mode
nnoremap ; :

" Map <Leader>ff to display all lines with keyword under cursor and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Fast jump out of insert mode
inoremap kj <ESC>

"move back and forth through previous and next buffers
nnoremap <silent> <leader>z :bp<cr>
noremap <silent> <leader>x :bn<cr>

nmap <leader>s <Plug>(wildfire-quick-select)

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" }

