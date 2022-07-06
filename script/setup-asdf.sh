#!/bin/bash

if ! command -v asdf >/dev/null; then
  if [ "$(uname)" = Darwin ]; then
    brew install asdf
  fi
  if [ "$(uname)" = Linux ]; then
    [ ! -e ~/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
  fi
fi

if [ "$(uname)" = Darwin ]; then
  # shellcheck source=/dev/null
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
fi
if [ "$(uname)" = Linux ]; then
  # shellcheck source=/dev/null
  . "$HOME/.asdf/asdf.sh"
  asdf update
fi

asdf plugin update --all

for p in $(asdf plugin list); do
  v=latest
  if [ "$p" = golang ]; then
    v=1.17
  fi
  if [ "$p" = java ]; then
    v=openjdk-17
  fi

  asdf install "$p" "$v"
  asdf global "$p" "$v"
done
