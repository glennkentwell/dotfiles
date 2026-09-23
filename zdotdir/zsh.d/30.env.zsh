#!/bin/zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
   # export VISUAL='subl'
 fi

LMSTUDIO="$HOME/.lmstudio/bin"
PYTHON="$HOME/Library/Python/3.11/bin"
GNUFIND="/opt/homebrew/opt/findutils/libexec/gnubin"
POSTGRES="/opt/homebrew/opt/postgresql@15/bin"
CARGO="$HOME/.cargo/bin"
GO="$HOME/go/bin"
HOME_LOCAL="$HOME/.local/bin"
HOME_BIN="$HOME/bin"
DOTFILES_BIN="$HOME/.dotfiles/bin"
export PATH="$DOTFILES_BIN:$HOME_BIN:$HOME_LOCAL:$POSTGRES:$GNUFIND:$GO:$CARGO:$PYTHON:$LMSTUDIO:$PATH"

export LESS="-F -X -R"

# https://unix.stackexchange.com/questions/721412/proper-way-of-setting-word-separators-in-zsh
# export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # rm /
export WORDCHARS='*?~&!#$%^'    # rm /-

unsetopt beep
