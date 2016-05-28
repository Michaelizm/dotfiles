# For Neovim
NVIM_TUI_ENABLE_TRUE_COLOR=1

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/zsh

#set Editor
export EDITOR="nvim"


#set highlight for cheat
export CHEATCOLORS=true

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=pygmalion

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy/mm/dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git svn cp tmux vagrant colored-man colorize github virtualenv pip python brew-cask brew jump osx zsh-syntax-highlighting)

# User configuration
export MANPATH="/usr/local/man:$MANPATH"
export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases
alias s='subl'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias zshconfig="nvim ~/.zshrc"
alias ll='ls -altr'
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias c="clear"
alias lsg="ll | grep"
alias histg="history | grep"
alias ..='cd ..; ls'
alias ...='cd ../..; ls'
alias ....='cd ../../..; ls'
alias m='mark'
alias ms='marks'
alias j='jump'


# Function
function ali {
ssh $1@120.25.88.28
}

function pipu {
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U
}

function brewu {
brew update && brew cask update && brew upgrade && brew cleanup && brew cask cleanup && brew prune && brew doctor
}


# ITerm2 integration
source ~/.iterm2_shell_integration.`basename $SHELL`
