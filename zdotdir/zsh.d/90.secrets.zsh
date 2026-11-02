#!/bin/zsh

SECRETS_DIR="$( dirname $ZDOTDIR )/.secrets"

find "$SECRETS_DIR" -type f -not -name '.*' -and -not -name '*.disabled' | while read -r fn; do
  export "$( basename "$fn" )"="$( cat "$fn" )"
done
