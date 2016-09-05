# dotfiles #

I spent lots of time gathering the best bits of top dotfile repos to my personal config, 
trying to make it elegant and powerful, 
meanwhile easier for maintaining and reference. 
Hoping you will like the way I reformed.

  * `vimrc.init` - for initialization, such as some import pre-settings and create undo-dir for `persist undo`, and you won't want to change it for a thousand years
  * `vimrc` - mainly for editor env setting and some default keystrokes remapping
  * `vimrc.bounds` - Pro user will like this, add your personal plugins in the form of `bound_group` and set up your key bindngs right below 

  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot3.png)

### Screenshot ###

  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot1.png)
  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot2.png)

-------------------------------------------------------------------------------

### Fonts for programing ###

  * [Fira Mono](https://mozilla.github.io/Fira/)
  * [Ubuntu Mono](http://font.ubuntu.com/)

### Pandora's box ###

  * [Homebrew](http://brew.sh/) and [Homebrew-cask](https://caskroom.github.io/), I will show you how to install the most components using them in the coming 
  * [iTerm2](https://www.iterm2.com/) is the only terminal you want to use on your Mac(and Mac only)
  * [Karabiner](https://pqrs.org/osx/karabiner/) and [Seil](https://pqrs.org/osx/karabiner/seil.html.en) will make up your keyboard 
  * [tpope/vim-scriptease](https://github.com/tpope/vim-scriptease) is a vim plugin for vim plugins, but the most cheerful thing is you can use it to find out
  all your current key bindings in use(include default key bindings and the one remapped by you, even the key bindings provided by plugins, you can find them out in 
  one place)


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
  nnoremap <silent> ,z :bp<CR>
  nnoremap <silent> ,x :bn<CR>
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

#### Edit and apply your vim config ####

  * `,ev` - (edit vimrc)Open all your vim configuration files(`~/.vimrc.init`, `~/.vimrc` and `~/.vimrc.bounds`) at the same time
  * `,sv` - (save vimrc)Reload and source all your vim configuration files
  * `,pi` - `:PlugInstall` 
  * `,pd` - `:PlugUpdate`
  * `,pg` - `:PlugUpgrade` Upgrade vim-plug itself
  * `,pk` - list all key bindings in a preview window, than use `/` to search, and press `q` to exit (how to read the preview? refer to `:h map-verbose`)

#### Buffer Navigation ####

  Every file you've opened will keep as buffers in the wings, you can tell which buffer to go from status line at the bottom
  * `,z` - go to previous buffer (just same as :bp)
  * `,x` - go to next buffer (:bn)
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
  * `,=` - equalize width and height of all windows
  * `H` - jump to the previous tab
  * `L` - jump to the next tab

#### Search/Code Navigation ####

  * `,ff` - display all lines with keyword under cursor and ask which one to jump to
  * `,fu` - `:Ctrlpfunky` to find all functions in current file
  * `,]` - toggle [Tagbar](https://github.com/majutsushi/tagbar), a class outline viewer
  * `/` - basic search
  * `,/` - toggle search hightlight
  * `zc` - close a fold (if the cursor is in an open fold)
  * `zo` - open a fold (if the cursor is in a closed fold) 
  * `zC` - close all folds at the cursor
  * `zR` - open all folds 
  *  all shortcuts for [EasyMontion](https://github.com/easymotion/vim-easymotion) are unchanged

#### File Navigation ####

  * `,os` - find a file and open it in a split window below
  * `,ov` - find a file and open it in a split window right
  * `,ot` - find a file and open it in a new tab
  * `Ctrl-p` - enter CtrlP
  * `,e` - open NERDTree and keep cursor on current file

  ```vim
  " o: open in prev window
  " go: preview
  " t: open in new tab
  " T: open in new tab silently
  " middle-click,
  " i: open split
  " gi: preview split
  " s: open vsplit
  " gs: preview vsplit
  "
  " ----------------------------
  " Directory node mappings~
  " single-click,
  " o: open & close node
  " O: recursively open node
  " x: close parent of node
  " X: close all child nodes of
  "    current node recursively
  " middle-click,
  " e: explore selected dir
  "
  " ----------------------------
  " Bookmark table mappings~
  " double-click,
  " o: open bookmark
  " t: open in new tab
  " T: open in new tab silently
  " D: delete bookmark
  "
  " ----------------------------
  " Tree navigation mappings~
  " P: go to root
  " p: go to parent
  " K: go to first child
  " J: go to last child
  " <C-j>: go to next sibling
  " <C-k>: go to prev sibling
  "
  " ----------------------------
  " Filesystem mappings~
  " C: change tree root to the
  "    selected dir
  " u: move tree root up a dir
  " U: move tree root up a dir
  "    but leave old root open
  " r: refresh cursor dir
  " R: refresh current root
  " m: Show menu
  " cd:change the CWD to the
  "    selected dir
  " CD:change tree root to CWD
  ```

#### Better keystrokes for common editing commands ####





## Thanks to ##
  * [square/maximum-awesome](https://github.com/square/maximum-awesome)
  * [spf13-vim](https://github.com/spf13/spf13-vim)
  * [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
