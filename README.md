# Bits of Vim #

## Screenshot ##

![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot1.png)
![image](https://github.com/Michaelizm/dotfiles/raw/master/doc/Screenshot2.png)

    Theme: Gruvbox
    Font: Fira Mono

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

## Key (re)Mappings ##

### Mapping prefix ###


  * Prefix for key setting

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

  * `,ev` - Open all your vim configuration files(`~/.vimrc.init`, `~/.vimrc` and `~/.vimrc.bounds`) and the same time
  * `,sv` - Reload and source all your vim configuration files
  More can be found about those 2 key bindings in `~/.vimrc.init`

#### Buffer Navigation ####

  * `,z` - go to previous buffer (just same as :bp)
  * `,x` - go to next buffer (:bn)
  * `:b3` - go to the third buffer
  Every file you've opened will keep as buffers in the wings, you can tell which buffer to go from status line at the bottom

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

  * `,f` - instantly Find definition of class (must have exuberant ctags installed)
  * `,F` - same as `,f` but in a vertical split
  * `,gf` or `Ctrl-f` - same as vim normal gf (go to file), but in a vertical split (works with file.rb:123 line numbers also)
  * `gF` - standard vim mapping, here for completeness (go to file at line number)
  * `K` - Search the current word under the cursor and show results in quickfix window
  * `,K` - Grep the current word up to next exclamation point (useful for ruby foo! methods)
  * `Cmd-*` - highlight all occurrences of current word (similar to regular `*` except doesn't move)
  * `,hl` - toggle search highlight on and off
  * `,gg` or `,ag` - Grep command line, type between quotes. Uses Ag Silver Searcher.
  * After searching with `,gg` you can navigate the results with `Ctrl-x` and `Ctrl-z` (or standard vim `:cn` and `:cp`)
  * `,gd` - Grep def (greps for 'def [function name]') when cursor is over the function name
  * `,gcf` - Grep Current File to find references to the current file
  * `//` - clear the search
  * `,,w` (alias `,<esc>`) or `,,b` (alias `,<shift-esc>`) - EasyMotion, a vimperator style tool that highlights jump-points on the screen and lets you type to get there.
  * `,mc` - mark this word for MultiCursor (like sublime). Use `Ctrl-n` (next), `Ctrl-p` (prev), `Ctrl-x`(skip) to add more cursors, then do normal vim things like edit the word.
  * `gK` - Opens the documentation for the word under the cursor.
  * Spacebar - Sneak - type two characters to move there in a line. Kind of like vim's `f` but more accurate.
  * `:Gsearch foo` - global search, then do your normal `%s/search/replace/g` and follow up with `:Greplace` to replace across all files. When done use `:wall` to write all the files.


#### File Navigation ####

  * `,t` - CtrlP fuzzy file selector
  * `,b` - CtrlP buffer selector - great for jumping to a file you already have open
  * `Cmd-Shift-M` - jump to method - CtrlP tag search within current buffer
  * `,jm` jump to models. Other `,j` mappings: `,jc` for controllers, `,jh` for helpers, etc. If you think of a concept and a letter, we've got you covered.
  * `Cmd-Shift-N` - NERDTree toggle (`Alt` in Linux)
  * `Ctrl-\` - Show current file in NERDTree
  * `Cmd-Shift-P` - Clear CtrlP cache

#### Better keystrokes for common editing commands ####

  * Ctrl-Space to autocomplete. Tab for snipmate snippets.
  * `Cmd-'`, `Cmd-"`, `Cmd-]`, `Cmd-)`, etc to change content inside those surrounding marks. You don't have to be inside them (`Alt` in Linux)
  * `,.` to go to last edit location (same as `'.`) because the apostrophe is hard on the pinky
  * `,ci` to change inside any set of quotes/brackets/etc

#### Tabs, Windows, Splits ####

  * Use `Cmd-1` thru `Cmd-9` to switch to a specific tab number (like iTerm and Chrome) - and tabs have been set up to show numbers (`Alt` in Linux)
  * `Ctrl-h,l,j,k` - to move left, right, down, up between splits. This also works between vim and tmux splits thanks to `vim-tmux-navigator`.
  * `Q` - Intelligent Window Killer. Close window `wincmd c` if there are multiple windows to same buffer, or kill the buffer `bwipeout` if this is the last window into it.
  * `vv` - vertical split (`Ctrl-w,v`)
  * `ss` - horizontal split (`Ctrl-w,s`)
  * `,qo` - open quickfix window (this is where output from Grep goes)
  * `,qc` - close quickfix

#### Utility

  * `Ctrl-p` after pasting - Use `p` to paste and `Ctrl-p` to cycle through previous pastes. Provided by YankRing.
  * `,yr` - view the yankring - a list of your previous copy commands. also you can paste and hit `ctrl-p` for cycling through previous copy commands
  * `crs`, `crc`, `cru` via abolish.vim, coerce to snake_case, camelCase, and UPPERCASE. There are more `:help abolish`
  * `:NR` - NarrowRgn - use this on a bit of selected text to create a new split with just that text. Do some work on it, then :wq it to get the results back.
  * `,ig` - toggle visual indentation guides
  * `,cf` - Copy Filename of current file (full path) into system (not vi) paste buffer
  * `,cn` - Copy Filename of current file (name only, no path)
  * `,yw` - yank a word from anywhere within the word (so you don't have to go to the beginning of it)
  * `,ow` - overwrite a word with whatever is in your yank buffer - you can be anywhere on the word. saves having to visually select it
  * `,ocf` - open changed files (stolen from @garybernhardt). open all files with git changes in splits
  * `,w` - strip trailing whitespaces
  * `sj` - split a line such as a hash {:foo => {:bar => :baz}} into a multiline hash (j = down)
  * `sk` - unsplit a link (k = up)
  * `,he` - Html Escape
  * `,hu` - Html Unescape
  * `,hp` - Html Preview (open in Safari)
  * `Cmd-Shift-A` - align things (type a character/expression to align by, works in visual mode or by itself) (`Alt` in Linux)
  * `:ColorToggle` - turn on #abc123 color highlighting (useful for css)
  * `:Gitv` - Git log browsers
  * `,gt` - Go Tidy - tidy up your html code (works on a visual selection)
  * `:Wrap` - wrap long lines (e.g. when editing markdown files)
  * `Cmd-/` - toggle comments (usually gcc from tComment) (`Alt` in Linux)
  * `gcp` (comment a paragraph)


## Thanks to ##
  * [square/maximum-awesome](https://github.com/square/maximum-awesome)
  * [spf13-vim](https://github.com/spf13/spf13-vim)
  * [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
