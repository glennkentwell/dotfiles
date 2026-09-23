#!/bin/zsh

listmonofonts() {
  fc-list | grep -i mono | awk -F: '{print $2}' | awk -F, '{print $1}' | sort | uniq
}

# choose a random font config file for ghostty
ghosttycfg() {
  lsdir="$HOME/.dotfiles/ghostty/"
  filez="$( ls -1 $lsdir | grep Mono )"
  echo "$filez" | wc -l | read fnum
  frnd=$(( $RANDOM % $fnum ))
  echo "$filez" | head -n $frnd | tail -n 1 | read cfg
  cp "${lsdir}${cfg}" "${lsdir}config" || echo failed cp config ?
}

function ansihtml() {
  ansifilter --html --line-numbers --anchors=self --style-ref=https://g3k.in/ansifilter.css $*
}
