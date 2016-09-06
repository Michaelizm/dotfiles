# dotfiles #

    
I spent lots of time gathering the best bits of top dotfile repos to my personal config, tweaking to make it elegant and powerful, meanwhile easier for maintaining and reference. Hoping you will like the way I reformed.

  * `vimrc.init` - for initialization, such as some import pre-settings and create undo-dir for `persist undo`, and you won't want to change it for a thousand years
  * `vimrc` - mainly for editor env setting and some default keystrokes remapping
  * `vimrc.bounds` - Pro user will like this, add your personal plugins in the form of `bound_group` and set up your key bindngs right below 

  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot3.png)

### Fonts for programing ###

  * [Fira Mono](https://mozilla.github.io/Fira/)
  * [Ubuntu Mono](http://font.ubuntu.com/)

### Pandora's box ###

  * [Homebrew](http://brew.sh/) and [Homebrew-cask](https://caskroom.github.io/), I will show you how to install the most components using them in the coming 
  * [Dash](https://github.com/rizzatti/dash.vim) will search for terms using the excellent [Dash.app](https://kapeli.com/dash) , making API lookups simple on your Mac(and Maconly)
  * [iTerm2](https://www.iterm2.com/) is the only terminal you want to use on your Mac(and Mac only)
  * [Karabiner](https://pqrs.org/osx/karabiner/) and [Seil](https://pqrs.org/osx/karabiner/seil.html.en) will make up your keyboard 
  * [tpope/vim-scriptease](https://github.com/tpope/vim-scriptease) is a vim plugin for vim plugins, but the most cheerful thing is you can use it to find out
  all your current key bindings in use(include the one remapped by you, and the key bindings provided by plugins, you can find them out in one place)

-------------------------------------------------------------------------------

### Screenshot ###

  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot1.png)
  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot2.png)

-------------------------------------------------------------------------------


## Prerequisite ##

  * [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) is more powerful and convient than bash, worth a try
  
  ```shell
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  ```
  
  * [vim-plug](https://github.com/junegunn/vim-plug) with super fast parallel installation/update 

  ```shell
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

  * [ag](https://github.com/ggreer/the_silver_searcher) is the replacement of `grep` and 5x faster than it 

  ```shell
  brew install the_silver_searcher
  ```

  * [ctags](https://github.com/universal-ctags/ctags) is essential for `CtrlP` and `Tagbar`

  ```shell
  brew install ctags
  ```

  * [Neovim](https://github.com/neovim/neovim) is a project that seeks to aggressively refactor Vim, still under heavy development and way better than it 
  
  ```shell
  brew install neovim
  ```
  
## Installation ##

  ```shell
  git clone https://github.com/Michaelizm/dotfiles.git ~/src/
  ./$HOME/src/dotfile/setup.sh
  ```

## Post Installation ##

  ```shell
  ln -s ~/.vim ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim
  ```

-------------------------------------------------------------------------------

## Editor env setting ##

  ```vim
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

  ```

-------------------------------------------------------------------------------

## Key (re)Mappings ##

### Something you may want to know about Mapping prefix ###

  `'i'` - effective in insert-mode  
  `'v'` - effective in visual-mode  
  `'c'` - effective in command-mode  
  `'n'` - effective in normal-mode  
  `'nore'` - not recursive  
  `'un'` - disable key binding

### Mapping sample ###

  * `'inoremap'` - effective in insert-mode and not recursive

  ```vim
  " Fast jump out of insert mode
  inoremap kj <ESC>
  ```

  * `'vnoremap'` - effective in visual-mode and not recursive

  ```vim
  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv
  ```

  * `'nnoremap'` - effective in normal-mode and not recursive

  ```vim
  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk
  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$
  " Fast enter command mode
  nnoremap ; :
  "Move back and forth through previous and next buffers
  nnoremap <silent> <leader>z :bp<CR>
  nnoremap <silent> <leader>x :bn<CR>
  ```

  * `'cmap'` - effective in command-mode and recursive

  ```vim
  " For when you forget to sudo.. Really Write the file.
  cmap w!! w !sudo tee % >/dev/null
  ```

  * `'nmap'` - effective in normal-mode and recursive

  ```vim
  " Most prefer to toggle search highlighting rather than clear the current
  nmap <silent> <leader>/ :set invhlsearch<CR>
  " Map <Leader>ff to display all lines with keyword under cursor and ask which one to jump to
  nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
  ```

  * `'map'` - effective in all modes and recursive

  ```vim
  map <leader>pi :PlugInstall<CR>
  map <leader>pd :PlugUpdate<CR>
  map <leader>pg :PlugUpgrade<CR>
 " Easier moving in windows
  map <C-J> <C-W>j<C-W>_
  map <C-K> <C-W>k<C-W>_
  map <C-L> <C-W>l<C-W>_
  map <C-H> <C-W>h<C-W>_
  " Some helpers to edit mode http://vimcasts.org/e/14
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
  ```

-------------------------------------------------------------------------------

### The frequent key bindings in use ###

All the key bindings are as both mnemonic and instinct as possible, you will get used to them in no time

#### vim config maintenance ####

  * `<space>ev` - (edit vimrc)Open all your vim configuration files(`~/.vimrc.init`, `~/.vimrc` and `~/.vimrc.bounds`) at the same time
  * `<space>sv` - (save vimrc)Reload and source all your vim configuration files
  * `<space>pi` - `:PlugInstall` 
  * `<space>pd` - `:PlugUpdate`
  * `<space>pg` - `:PlugUpgrade` Upgrade vim-plug itself
  * `<space>pk` - list all key bindings in a preview window, than use `/` to search, and press `q` to exit (how to read the preview? refer to `:h map-verbose`)

#### Buffer Navigation ####

  Every file you've opened will keep as buffers in the wings, you can tell which buffer to go from status line at the bottom
  * `<space>z` - go to previous buffer (just same as :bp)
  * `<space>x` - go to next buffer (:bn)
  * `:b3` - go to the third buffer

#### Cursor and Page Navigation ####

  * `Ctrl-o` - jump to previous cursor position(default in vim)
  * `Ctrl-i` - opposite of Ctrl-O(default in vim)
  * `Ctrl-d` - Pagedown(default in vim)
  * `Ctrl-u` - Pageup(default in vim)
  * `gg` - go to the start of file(default in vim)
  * `G` - go to the end of file(default in vim)

#### Window/Tab Navigation ####

  * `Ctrl-k` - jump to the window above and to the full height
  * `Ctrl-j` - jump to the window below and to the full height
  * `Ctrl-h` - jump to the left window and to the full height
  * `Ctrl-l` - jump to the right window and to the full height
  * `<space>=` - equalize width and height of all windows
  * `H` - jump to the previous tab
  * `L` - jump to the next tab

#### Search/Code Navigation ####

  * `b` and `w` - lower case b/w is for moving backward/forward of a 'word'
  * `B` and `W` - upper case B/W is for moving backward/forward of a 'WORD' (wondering the diff between 'word' and 'WORD'? check `:h word`)
  * `<space>ff` - display all lines with keyword under cursor and ask which one to jump to
  * `<space>fu` - `:Ctrlpfunky` to find all functions in current file
  * `<space>]` - toggle [Tagbar](https://github.com/majutsushi/tagbar), a class outline viewer
  * `/` - basic search
  * `<space>/` - toggle search hightlight
  * `zc` - close a fold (if the cursor is in an open fold)
  * `zo` - open a fold (if the cursor is in a closed fold) 
  * `zC` - close all folds at the cursor
  * `zR` - open all folds 
  *  all shortcuts for [EasyMontion](https://github.com/easymotion/vim-easymotion) stay still 
     * `<space><space>w` or `<space><space>b` - toggle 'word' motion 
     * `<space><space>W` or `<space><space>B` - toggle 'WORD' motion 
     * `<space><space>s` - input one character then jumping there
     * `<space><space>j` - line downward
     * `<space><space>k` - line upward
    

#### File Navigation ####

  * `<space>os` - find a file and open it in a split window below
  * `<space>ov` - find a file and open it in a split window right
  * `<space>ot` - find a file and open it in a new tab
  * `Ctrl-p` - is the better way to find something in your system for opening it, default enter file mode, use `Ctrl-f` and `Ctrl-b` to cycle between modes
      * `CtrlP` - file mode
      * `CtrlPBuffer` - buffer mode
      * `CtrlPMRU` - 'MRU' is for most recently used, order the file list in usage
      * `CtrlPMixed` - (optional)to search in Files, Buffers and MRU files at the same time 

      ```vim
      While CtrlP is invoking:
      " Press <Ctrl-d> to switch to filename only search instead of full path.
      " Press <Ctrl-r> to switch to regexp mode.
      " Use <Ctrl-j>, <Ctrl-k> or the arrow keys to navigate the result list.
      " Use <Ctrl-t> or <Ctrl-v>, <Ctrl-s> to open the selected entry in a new tab or in a new split.
      " Use <Ctrl-n>, <Ctrl-p> to select the next/previous string in the prompt's history.
      " Use <Ctrl-z> to mark/unmark multiple files and <Ctrl-o> to open the marked files
      ```

  * `<space>e` - open NERDTree and keep cursor on current file. (NERDTree can be complex, but we don't have to make it that way, the essential is fine)

  ```vim
  While NERDTree is invoking:
  " o: open in prev window
  " t: open in new tab
  " i: open split
  " s: open vsplit
  ```

  * `<space>a<space>` - invoke `ag` which aims at searching key words in massive files, kind of `grep`, default search under current path

  ```vim
  :Ack[!] [options] {pattern} [{directory}] 
  " ?       display a quick summary of these mappings.
  " o       open file (same as Enter).
  " O       open file and close the quickfix window.
  " go      preview file (open but maintain focus on ack.vim results).
  " t       open in a new tab.
  " T       open in new tab without moving to it.
  " h       open in horizontal split.
  " H       open in horizontal split, keeping focus on the results.
  " v       open in vertical split.
  " gv      open in vertical split, keeping focus on the results.
  " q       close the quickfix window.
  ```

#### Better keystrokes for common editing commands ####

  * `Ctrl-o o` - jump to the next line immediately from insert mode

  * `Ctrl-o O` - jump to the previous line immediately from insert mode

  * [vim-surround](https://github.com/tpope/vim-surround) is a tool for dealing with pairs of "surroundings."  Examples of surroundings include parentheses, quotes, and HTML tags. Provided are mappings to allow for removing, changing, and adding surroundings.

      * `ds'` - delete surroundings
      * `cs"'` - change surroundings
      * `ysiw)` - surround the word under cursor
      * `yss)` - surround current line
      * `vSf` - than type 'print', see what will happen
      * `vS)` - surround the selected part

  * [sessionman](https://github.com/vim-scripts/sessionman.vim) will help you manage your session

      * `<space>sl` show session list
      * `<space>ss` save session and input a name for it
      * `<space>sc` close current session

  * [undotree](https://github.com/mbbill/undotree) is an undo history visualizer

      * `<space>u` toggle undotree, navigate with 'j/k', press 'enter' to confirm and 'q' to exit
      * `u` undo
      * `Ctrl-r` redo

  * [vim-fugitive](https://github.com/tpope/vim-fugitive) is a awesome git wrapper

      * `<leader>gs` - git status
      * `<leader>gd` - git diff
      * `<leader>gc` - git commit
      * `<leader>gb` - git blame
      * `<leader>gl` - git log
      * `<leader>gp` - git push
      * `<leader>gr` - git read
      * `<leader>gw` - git write
      * `<leader>ge` - git edit
      * `<leader>gi` - git add -p %

  * Snippets/AutoComplete with [YouCompleteMe](https://github.com/Valloric/YouCompleteMe), SirVer/ultisnips, honza/vim-snippets 



## Thanks to ##
  * [square/maximum-awesome](https://github.com/square/maximum-awesome)
  * [spf13-vim](https://github.com/spf13/spf13-vim)
  * [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
