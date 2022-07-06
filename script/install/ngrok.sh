#!/bin/bash

if ! which ngrok >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install --cask ngrok
  [ "$(uname)" = Linux ] && sudo tar xvzf ~/Downloads/ngrok-stable-linux-amd64.tgz -C /usr/local/bin
fi
