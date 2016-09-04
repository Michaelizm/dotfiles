# Best bits of Vim #

## Screenshot ##

![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot1.png)
![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot2.png)

## Something you should try for your Mac##

  * [Neovim](http://lri.me/)
  * [oh-my-zsh](http://hotfusion.nl/)
  * [iTerm2](http://nicolasgallagher.com/)
  * [Karabiner](https://pqrs.org/osx/karabiner/) and [Seil](https://pqrs.org/osx/karabiner/seil.html.en)

## Fonts for programing ##

  * [Fira Mono](https://mozilla.github.io/Fira/)
  * [Ubuntu Mono](http://font.ubuntu.com/)

## Prerequisite ##

  * ag
  * ctags

-------------------------------------------------------------------------------

## Key (re)Mappings ##

### Mapping prefix ###

1. `'i'` - effective in insert mode
2. `'v'` - effective in visual mode
3. `'c'` - effective in command mode
4. `'n'` - effective in normal mode
5. `'nore'` - not recursive
6. `'un'` - disable key binding

### Mapping sample ###

  * `'inore'` - effective in insert mode and not recursive

  ```vim
  inoremap kj <ESC>
  ```
  * `'vnore'` - effective in visual mode and not recursive

  ```vim
  vnoremap < <gv
  vnoremap > >gv
  vnoremap . :normal .<CR>
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
  nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>
  ```

#### Edit and apply your Vimrc ####

  More can be found about those 2 key bindings in `~/.vimrc.init`  
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
  Please use [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)  
  * `Ctrl-p` - enter CtrlP



#### Search/Code Navigation ####


#### File Navigation ####


#### Better keystrokes for common editing commands ####


#### Tabs, Windows, Splits ####


#### Utility



## Thanks to ##
  * [square/maximum-awesome](https://github.com/square/maximum-awesome)
  * [spf13-vim](https://github.com/spf13/spf13-vim)
  * [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
