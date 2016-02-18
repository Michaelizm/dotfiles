# For Gruvbox Theme
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# Better umask
umask 022

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/zsh

#set Editor
export EDITOR="vim"

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
export PATH="/Users/zhangchen/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"


source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
alias v='vim'
alias vi='vim'
alias vim='vim'
alias zshconfig="vim ~/.zshrc"
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
alias .....='cd ../../../..; ls'
alias ali='ssh vagrant@120.25.88.28'
alias m='mark'
alias ms='marks'
alias j='jump'
alias gs='git svn'
alias brewu='brew update  && brew cask update && brew upgrade --all && brew cleanup && brew prune && brew doctor'


# Function
copy() {
	if [[ $1 =~ ^-?[hH] ]]; then

		echo "Intelligently copies command results, text file, or raw text to"
		echo "OS X clipboard"
		echo
		echo "Usage: copy [command or text]"
		echo "  or pipe a command: [command] | copy"
		return
	fi

	local output
	local res=false
	local tmpfile="${TMPDIR}/copy.$RANDOM.txt"
	local msg=""

	if [[ $# == 0 ]]; then
		output=$(cat)
		msg="Input copied to clipboard"
		res=true
	else
		local cmd=""
		for arg in $@; do
			cmd+="\"$(echo -en $arg|sed -E 's/"/\\"/g')\" "
		done
		output=$(eval "$cmd" 2> /dev/null)
		if [[ $? == 0 ]]; then
			msg="Results of command are in the clipboard"
			res=true
		else
			if [[ -f $1 ]]; then
				output=""
				for arg in $@; do
					if [[ -f $arg ]]; then
						type=`file "$arg"|grep -c text`
						if [ $type -gt 0 ]; then
							output+=$(cat $arg)
							msg+="Contents of $arg are in the clipboard.\n"
							res=true
						else
							msg+="File \"$arg\" is not plain text.\n"
						fi
					fi
				done
			else
				output=$@
				msg="Text copied to clipboard"
				res=true
			fi
		fi
	fi

	$res && echo -ne "$output" | pbcopy -Prefer txt
	echo -e "$msg"
}

export PATH="$HOME/.bin:$PATH"
