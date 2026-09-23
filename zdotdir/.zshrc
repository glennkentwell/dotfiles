#!/bin/zsh

source $ZDOTDIR/zshrc.10.timing.zsh

# dot qualifier to ensure only regular files are matched
# N qualifier
for ZSH_FILE in "${ZDOTDIR:-$HOME}"/zsh.d/*.zsh(.N); do
  t_start=$EPOCHREALTIME
  source "${ZSH_FILE}" 2>&1 >> "$LOG_FILE"
  t_now=$EPOCHREALTIME
  log printf "%-60s %8.2f ms\n" $ZSH_FILE $(( (t_now - t_start) * 1000 ))
done

log_timings