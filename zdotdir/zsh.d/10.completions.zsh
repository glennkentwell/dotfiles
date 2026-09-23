#!/bin/zsh

autoload -Uz compinit
compinit

# zsh-autosuggestions
BREW_ZSH_AS="/opt/homebrew/share/zsh-autosuggestions"
[ -s $BREW_ZSH_AS/zsh-autosuggestions.zsh ] && source $BREW_ZSH_AS/zsh-autosuggestions.zsh

BREW_PREFIX=/opt/homebrew
# zsh-completions
if [[ ! -d $BREW_PREFIX ]]; then
  if type brew &>/dev/null; then
    BREW_PREFIX=$( brew --prefix )
	  FPATH=$BREW_PREFIX/share/zsh-completions:$FPATH
	fi
fi
# chmod -R go-w '/opt/homebrew/share/zsh'
# rm -f ~/.zcompdump; compinit

# aws completions
# autoload bashcompinit && bashcompinit
# complete -C /opt/homebrew/bin/aws_completer aws
# complete -C /opt/homebrew/bin/kubectl completion zsh
#

# wtf TODO
# command -v steampipe >/dev/null && $(command -v steampipe) completion zsh > "${fpath[1]}/steampipe"
command -v op >/dev/null && eval "$(op completion zsh)"; compdef _op op

command -v fzf > /dev/null && source <(fzf --zsh)

zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' menu select

# from zsh_codex plugin docs
# https://github.com/tom-doerr/zsh_codex
bindkey '^X' create_completion

# command -v >/dev/null starship && eval "$(starship init zsh)"

function completion_add() {
  "$1" completion > "/opt/homebrew/share/zsh-completions/_${1}"
}
alias addcompletion="completion_add $@"

fpath+=~/.zfunc
# To enable autocompletion you should add the following script to startup scripts of your shell.
# It is probably located at ~/.zshrc
# autoload -Uz compinit
# compinit

