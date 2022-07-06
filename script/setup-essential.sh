#!/bin/bash

if [ "$(uname)" = Darwin ]; then
  if ! command -v brew >/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  brew upgrade
  brew install fish git curl wget vim
fi

if [ "$(uname)" = Linux ]; then
  sudo apt update -yqq
  sudo apt install -yqq fish git curl wget vim gcc sudo
fi
