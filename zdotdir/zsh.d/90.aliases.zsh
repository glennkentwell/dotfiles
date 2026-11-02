#!/bin/zsh

alias ls="ls -h --color"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
# alias nvim="nvim -u $HOME/.vimrc"
#alias vi=hx
#alias vim=hx
# alias cat=ccat
# alias less=cless
alias 1p=op
alias 1password=op
# alias kubectl=kubecolor
alias tcping="nmap -Pn -np"
alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"

alias cs=claude-squad
alias notes='$HOME/bin/idea --edit $HOME/notes/notes.md'
alias datestamp="date +%Y%m%d_%H%M%S"
alias datemonth="date +%Y%m"
alias dateday="date +%Y%m%d"
alias datehour="date +%Y%m%d_%H"
alias dateminute="date +%Y%m%d_%H%M"
alias datesecondsutc="date -uIseconds"
alias dateseconds="date -Iseconds"
alias datestamputc="date -u +%Y%m%d_%H%M%S%z"
alias datetimestamp="date +%Y%m%d_%H%M%S"
alias datetimestamptz="date +%Y%m%d_%H%M%S%z"
alias datefromunix="date -j -f %s +%Y-%m-%dT%H:%M:%S" 
dateunixtsfromjson() {
  date -j -f %Y-%m-%dT%H:%M:%S +%s 1970-01-01T23:59:57
}
datefromunixtimestamp() {
  defaultdate="$( dateunixtsfromjson )"
  date -j -f %s +%Y-%m-%dT%H:%M:%S ${1:-$defaultdate} 
}
# alias dateyesterday='date -j -f %s $(( $( date +%s ) - 86400 )) +%Y-%m-%d'
datedaysago() {
  days=${1:-1}
  printf '%s is %d days ago\n' $( date -j -f %s $(( $( date +%s ) - (86400*$days) )) +%Y-%m-%d ) $days
}
dateyesterday() {
  datedaysago
}
alias timestamp="date +%Y%m%d_%H%M%S"
alias timestamptz="date +%Y%m%d_%H%M%S%z"

# CUID2 alias
alias cuid="npx @paralleldrive/cuid2"

# launch alacritty and disown it
# alias a='$HOME/.nix-profile/bin/alacritty & disown; [[ $SHLVL -gt 1 ]] && exit'
alias a="open ~/Applications/Alacritty.app"

function ask() {
  local promptq="${1:-are you ok? (y/N) }"
  local var="$2"
  if [ -n "$BASH_VERSION" ]; then
    IFS= read -r -N 1 -p "$promptq" REPLY
    printf "\nreply: %s\n" "$REPLY"
  elif [ -n "$ZSH_VERSION" ]; then
    read -rq "REPLY?$promptq"
    printf "\nreply: %s\n" "$REPLY"
  else
    echo "unknown shell"
    return 1
  fi
  [[ -n "$var" ]] && eval "$var=\"$REPLY\""
  [[ "$REPLY" =~ ^[Yy]$ ]]
}

datejson() {
    DAYSAGO=${1-0}
    WRAP=${2}
    jsondt=$( date -Iseconds -r $(( $( date +%s ) - ($DAYSAGO * 24 * 60 * 60) )) )
    if [[ -n $WRAP ]]; then
        echo $jsondt | sed -e 's/^/{"date":"/g' -e 's/$/"}/g'
    else
        echo $jsondt
    fi
}
alias jsondate="datejson $1"
alias jsondatewrap="datejson $1 w"
tzdates_orig() {
    timezones=(UTC Australia/Brisbane Australia/Melbourne America/Resolute America/New_York America/Los_Angeles Europe/London)
    (for tz in $timezones; do
        printf "%s\t%s\n" "$( date -z $tz "$@" )" $tz
        # dt="$( TZ=$tz date )"
        # dt="$( TZ=$tz dateseconds | sed -e 's/T/ /' | sed -E 's/[0-9]([+-])[0-9]/ \1/' )"
        # dt="$( TZ=$tz date -Iseconds | sed -e 's/T/ /' | sed -E 's/([-\+][0-9]+:[0-9]+)/\t\1/g' )"
        # printf "%s\t%s\n" $tz $dt
      done) | sort -n | column -t
}
tzdates () {
   local -a timezones=(
      UTC
      Australia/Brisbane
      Australia/Melbourne
      America/Resolute
      America/New_York
      America/Los_Angeles
      Europe/London
   )
   local tz hour emoji

   (
      for tz in "${timezones[@]}"; do
         hour=$(date -z "$tz" +%H)

         case "$hour" in
            0[6-9]|1[01]) emoji="🌅" ;; # Morning:   06:00–11:59
            1[2-6])      emoji="🌆" ;; # Afternoon: 12:00–16:59
            1[7-9]|2[01]) emoji="🌃" ;; # Evening:   17:00–21:59
            *)           emoji="🌙" ;; # Late:      22:00–05:59
         esac

         printf "%s\t%s %s\n" "$(date -z "$tz" "$@")" "$emoji" "$tz"
      done
   ) | sort -n
}

alias datestz="tzdates"

which gfind >/dev/null && alias find=gfind

[[ -s $HOME/bin/opencode-sessions ]] && alias ocs="$HOME/bin/opencode-sessions"

# athenacli https://github.com/dbcli/athenacli

# gh cli
repos() {
  num="${1:-100}"
  gh repo list $GITHUB_ORG --json name,createdAt,updatedAt,sshUrl,url --no-archived --limit $num 
}
reposbyupdated() {
  repos "$@" | jq -c 'sort_by(.updatedAt) | .[] | { createdAt, updatedAt, name, sshUrl, url }' 
}
reposbycreated() {
  repos "$@" | jq -c 'sort_by(.createdAt) | .[]'
}
