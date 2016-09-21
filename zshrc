#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Aliases
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
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
alias pipu="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U"
alias p='percol'

alias zshconfig="nvim ~/.zshrc"




# Function
function ali {
ssh -p 222 vagrant@120.25.88.28
}

function ppgrep() {
    if [[ $1 == "" ]]; then
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
}

function ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""            # options only
    else
        QUERY=$1            # with a query
        [[ $# > 0 ]] && shift
    fi
    ppgrep $QUERY | xargs kill $*
}

function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

