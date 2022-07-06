#!/bin/bash

if [ "$(uname)" = Darwin ]; then
  for cask in firefox \
    google-chrome \
    visual-studio-code \
    docker \
    intellij-idea \
    android-studio \
    unity-hub \
    lens \
    arduino \
    fitbit-os-simulator \
    slack \
    zoom \
    1password \
    raycast \
    font-jetbrains-mono \
    google-japanese-ime \
    kindle; do

    if ! brew list | grep -E '$'"$cask"'^'; then
      brew install --cask "$cask"
    fi

  done
fi
