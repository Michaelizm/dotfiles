# dotfiles #

I spent lots of time gathering the best bits of top dotfile repos to my personal config, 
trying to make it elegant and powerful, 
meanwhile easier for maintaining and reference. 
Hoping you will like the way I reformed.

  * `vimrc.init` - for initialization, such as some import pre-setting and create undo-dir for `persist undo`, and you won't want to change it for a thousand years
  * `vimrc` - mainly for editor env setting and some default keystrokes remapping
  * `vimrc.bounds` - Pro user will like this, add your personal plugins in the form of `bound_group` and set up your key bindngs right below 

  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot3.png)

## Screenshot ##

  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot1.png)
  ![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot2.png)

## Fonts for programing ##

  * [Fira Mono](https://mozilla.github.io/Fira/)
  * [Ubuntu Mono](http://font.ubuntu.com/)

## Pandora's box ##

  * [Homebrew](http://brew.sh/) and [Homebrew-cask](https://caskroom.github.io/), I will show you how to install the most components using them in the coming 
  * [Neovim](https://github.com/neovim/neovim) is a project that seeks to aggressively refactor Vim, still under heavy development and way better than it 
  * [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) is more powerful and convient than bash, worth a try
  * [iTerm2](https://www.iterm2.com/) is the only terminal you want to use on your Mac(and Mac only)
  * [Karabiner](https://pqrs.org/osx/karabiner/) and [Seil](https://pqrs.org/osx/karabiner/seil.html.en) will make up your keyboard 

## Prerequisite ##

  * [vim-plug](https://github.com/junegunn/vim-plug) with super fast parallel installation/update 
  * [ag](https://github.com/ggreer/the_silver_searcher) is the replacement of `grep` and 5x faster than it 
  * [ctags](https://github.com/universal-ctags/ctags) is essential for `CtrlP`

## Installation ##
  ```shell

  ```

-------------------------------------------------------------------------------

## Key (re)Mappings ##

### Mapping prefix ###

  `'i'` - effective in insert mode  
  `'v'` - effective in visual mode  
  `'c'` - effective in command mode  
  `'n'` - effective in normal mode  
  `'nore'` - not recursive  
  `'un'` - disable key binding

### Mapping sample ###

  * `'inore'` - effective in insert mode and not recursive

  ```vim
  inoremap kj <ESC>
  ```
  * `'vnore'` - effective in visual mode and not recursive

  ```vim
  vnoremap < <gv
  vnoremap > >gv
  ```
  * `'cnore'` - effective in command mode and not recursive

  ```vim
  cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
  ```
  * `'nnore'` - effective in normal mode and not recursive

  ```vim
  noremap j gj
  noremap k gk
  nnoremap Y y$
  nnoremap ; :
  nnoremap <silent> ,z :bp<CR>
  nnoremap <silent> ,x :bn<CR>
  ```

#### Edit and apply your Vimrc ####

  * `,ev` - Open all your vim configuration files(`~/.vimrc.init`, `~/.vimrc` and `~/.vimrc.bounds`) and the same time
  * `,sv` - Reload and source all your vim configuration files

#### Buffer Navigation ####

  Every file you've opened will keep as buffers in the wings, you can tell which buffer to go from status line at the bottom
  * `,z` - go to previous buffer (just same as :bp)
  * `,x` - go to next buffer (:bn)
  * `:b3` - go to the third buffer

#### Cursor and Page Navigation ####

  * `Ctrl-o` - jump to last cursor position(default in vim)
  * `Ctrl-i` - opposite of Ctrl-O(default in vim)
  * `Ctrl-d` - Pagedown(default in vim)
  * `Ctrl-u` - Pageup(default in vim)
  * `gg` - go to the start of file(default in vim)
  * `G` - go to the end of file(default in vim)

#### Window/Tab Navigation ####
  The better way would be [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)
  * `Ctrl-p` - enter CtrlP



#### Search/Code Navigation ####


#### File Navigation ####


#### Better keystrokes for common editing commands ####





## Thanks to ##
  * [square/maximum-awesome](https://github.com/square/maximum-awesome)
  * [spf13-vim](https://github.com/spf13/spf13-vim)
  * [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
