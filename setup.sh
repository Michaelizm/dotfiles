#!/usr/bin/env bash

############################  SETUP PARAMETERS
[ -z "$APP_PATH" ] && APP_PATH="$HOME/src/dotfiles"
debug_mode='0'

############################  BASIC SETUP TOOL
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

############################ SETUP FUNCTIONS
create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/vimrc"               "$target_path/.vimrc"
    lnif "$source_path/vimrc.bundles"       "$target_path/.vimrc.bundles"
    lnif "$source_path/vimrc.init"          "$target_path/.vimrc.init"
    lnif "$source_path/tmux.conf"           "$target_path/.tmux.conf"

    lnif "$source_path/percol.d"            "$target_path/.percol.d"

    ret="$?"
    success "Setting up symlinks."
    debug
}

############################ MAIN()
variable_set "$HOME"
program_must_exist "nvim"
program_must_exist "tmux"
program_must_exist "git"
create_symlinks "$APP_PATH" "$HOME"

