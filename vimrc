" Basic
set nocompatible
set shell=/bin/zsh

if filereadable(expand("~/.vimrc.init"))
    source ~/.vimrc.init
endif

if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" General {
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
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

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


filetype plugin indent on           " Automatically detect file types.
syntax on                           " Syntax highlighting
set mouse=a                         " Automatically enable mouse usage
set mousehide                       " Hide the mouse cursor while typing
scriptencoding utf-8

if has('clipboard')
    if has('unnamedplus')           " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else                            " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
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

" Restore cursor
function! ResCur()
    if line("'\"") <= line("$")
        silent! normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" }

" Vim UI {
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_termcolors=16
let g:gruvbox_italic=1
colorscheme gruvbox

if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
    if !exists('g:airline_theme')
        let g:airline_theme = 'gruvbox'
    endif
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    if !exists('g:airline_powerline_fonts')
        let g:airline_left_sep = '▶'
        let g:airline_left_alt_sep = '❯'
        let g:airline_right_sep = '◀'
        let g:airline_right_alt_sep = '❮'
    endif
endif

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
    if !exists('g:override_bundles')
        set statusline+=%{fugitive#statusline()} " Git Hotness
    endif
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
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
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
"fast enter command mode
nnoremap ; :
" Map <Leader>ff to display all lines with keyword under cursor and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" fast jump out of insert mode
inoremap kj <ESC>
" }

" Functions {
function! s:ExpandFilenameAndExecute(command, file)
    execute a:command . " " . expand(a:file, ":p")
endfunction
function! s:EditConfig()
    call <SID>ExpandFilenameAndExecute("tabedit", "~/.vimrc.init")
    call <SID>ExpandFilenameAndExecute("tabedit", "~/.vimrc")
    call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.bundles")
    execute bufwinnr(".vimrc") . "wincmd w"
endfunction
execute "noremap " . g:edit_config_mapping . " :call <SID>EditConfig()<CR>"
execute "noremap " . g:apply_config_mapping . " :source ~/.vimrc<CR>".":filetype detect<CR>:exe \":echo \'vimrc reloaded\'\"<CR>"
" }
