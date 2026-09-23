#!/bin/zsh

export PYTHONSTARTUP="$HOME/.pythonrc"
alias python=python3
alias pip=pip3

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"
# https://github.com/pyenv/pyenv-virtualenv
command -v pyenv >/dev/null && eval "$(pyenv virtualenv-init -)"