#!/bin/zsh

zmodload zsh/datetime
t_init=$EPOCHREALTIME

LOG_TIMESTAMP="$( date +%Y%m%d-%H%M.%s )"
LOG_TIMINGS=true
LOG_DIR="$HOME/.local/share/dotfiles/log"
LOG_FILE="${LOG_DIR}/zshrc.$LOG_TIMESTAMP.log"
mkdir -p "$( dirname $LOG_FILE )"
echo $LOG_TIMESTAMP > "$LOG_FILE"
ln -fs "$LOG_FILE" "${LOG_DIR}/latest.log"

log() {
  "$@" >> "$LOG_FILE"
}

log_timings() {
  log printf '%.0s-' {1..72}; log echo
  log printf "%-60s %8.2f ms\n" TOTAL $(( (t_now - t_init) * 1000 ))

  tail -n 1 "${LOG_DIR}/latest.log"
}
