#!/bin/bash

if ! which bat >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install bat
  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    curl -sSL https://github.com/sharkdp/bat/releases/download/v0.20.0/bat_0.20.0_amd64.deb >bat.deb &&
    sudo dpkg -i bat.deb &&
    popd
fi
