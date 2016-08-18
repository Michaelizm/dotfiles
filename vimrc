" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
    " }

    " Basics {
        set nocompatible
        set shell=/bin/zsh

        if filereadable(expand("~/.vimrc.init"))
            source ~/.vimrc.init
        endif

        if filereadable(expand("~/.vimrc.bundles"))
            source ~/.vimrc.bundles
        endif
    " }

" }

" General {

    set background=dark                 " Assume a dark background

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
    if !exists('g:no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    endif

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

    " Setting up the directories {
    set backup
    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

    " }

" }

" Vim UI {

    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_termcolors=16
    let g:gruvbox_italic=1
    colorscheme gruvbox

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

" }

" Formatting {

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
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ','
    let mapleader = ','

    " The default mappings for editing and applying the  configuration
    let s:edit_config_mapping = '<leader>ev'
    let s:apply_config_mapping = '<leader>sv'

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

" Plugins {

    " TextObj Sentence {
        if count(g:bundle_groups, 'writing')
            augroup textobj_sentence
              autocmd!
              autocmd FileType markdown call textobj#sentence#init()
              autocmd FileType textile call textobj#sentence#init()
              autocmd FileType text call textobj#sentence#init()
            augroup END
        endif
    " }

    " TextObj Quote {
        if count(g:bundle_groups, 'writing')
            augroup textobj_quote
                autocmd!
                autocmd FileType markdown call textobj#quote#init()
                autocmd FileType textile call textobj#quote#init()
                autocmd FileType text call textobj#quote#init({'educate': 0})
            augroup END
        endif
    " }

    " Misc {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            let g:NERDShutUp=1
        endif
        if isdirectory(expand("~/.vim/bundle/matchit.zip"))
            let b:match_ignorecase = 1
        endif
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }

    " Tabularize {
        if isdirectory(expand("~/.vim/bundle/tabular"))
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            nmap <leader>sl :SessionList<CR>
            nmap <leader>ss :SessionSave<CR>
            nmap <leader>sc :SessionClose<CR>
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

    " PyMode {
        if !has('python') && !has('python3')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/bundle/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
        endif
    " }

    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_match_window = 'order:ttb,max:20'
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                let g:ctrlp_extensions = ['funky']
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    "}

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <leader>] :TagbarToggle<CR>
        endif
    "}

    " Fugitive {
        " Instead of reverting the cursor to the last position in the buffer, we set it to the first line when editing a git commit message
        au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
        if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    "}

    " YouCompleteMe {
        if count(g:bundle_groups, 'youcompleteme')
            let g:acp_enableAtStartup = 0

            " enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files = 1

            " remap Ultisnips for compatibility for YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " For snippet_complete marker.
            if !exists("g:spf13_no_conceal")
                if has('conceal')
                    set conceallevel=2 concealcursor=i
                endif
            endif

            set completeopt-=preview
        endif
    " }

    " UndoTree {
        if isdirectory(expand("~/.vim/bundle/undotree/"))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " indent_guides {
        if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }

    " Wildfire {
    let g:wildfire_objects = {
                \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
                \ "html,xml" : ["at"],
                \ }
    " }

    " vim-airline {
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
    " }

    " Dash {
        " Set configuration options for Dash(for Mac only)
        if isdirectory(expand("~/.vim/bundle/dash.vim/"))
            nmap <silent> <leader>d <Plug>DashSearch
        endif
    " }

" }

" GUI Settings {

    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
    endif

" }

" Functions {

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        if exists('g:consolidated_directory')
            let common_dir = g:consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    let g:NERDSpaceDelims=1
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    function! s:ExpandFilenameAndExecute(command, file)
        execute a:command . " " . expand(a:file, ":p")
    endfunction
     
    function! s:EditConfig()
        call <SID>ExpandFilenameAndExecute("tabedit", "~/.vimrc.init")
        call <SID>ExpandFilenameAndExecute("tabedit", "~/.vimrc")
        call <SID>ExpandFilenameAndExecute("vsplit", "~/.vimrc.bundles")
        execute bufwinnr(".vimrc") . "wincmd w"
    endfunction
     
    execute "noremap " . s:edit_config_mapping . " :call <SID>EditConfig()<CR>"
    execute "noremap " . s:apply_config_mapping . " :source ~/.vimrc<CR>".":filetype detect<CR>:exe \":echo \'vimrc reloaded\'\"<CR>"
" }
