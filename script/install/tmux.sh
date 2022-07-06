#!/bin/bash

if ! which tmux >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install tmux
  [ "$(uname)" = Linux ] && sudo apt install -yqq tmux
fi

if [ ! -e ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
