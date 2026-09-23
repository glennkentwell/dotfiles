#!/bin/zsh

# from nickm 2024-03-19 
search-history () {
  local cmd="$(history | fzf --tac | awk 'BEGIN { FS = "  " }; {print $2}')"
  echo -e "\nCopied to clipboard:\n\t$cmd";
  echo -n $cmd | pbcopy;
}
alias shist="search-history"

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
# unsetopt share_history
