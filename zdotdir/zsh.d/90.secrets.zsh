#!/bin/zsh

SECRETS_DIR="$( dirname $ZDOTDIR )/.secrets"

find "$SECRETS_DIR" -type f -not -name '.*' | while read -r fn; do
  export "$( basename "$fn" )"="$( cat "$fn" )"
done
