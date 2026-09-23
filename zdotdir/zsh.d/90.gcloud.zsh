#!/bin/zsh

CLOUD_SDK_PATH="$HOME/Downloads/google-cloud-sdk"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$CLOUD_SDK_PATH/path.zsh.inc" ]; then
  source "$CLOUD_SDK_PATH/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$CLOUD_SDK_PATH/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$CLOUD_SDK_PATH/google-cloud-sdk/completion.zsh.inc"
fi

