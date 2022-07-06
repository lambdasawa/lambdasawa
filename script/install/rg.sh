#!/bin/bash

if ! which rg >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install ripgrep
  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    sudo apt-get download ripgrep &&
    sudo dpkg --force-overwrite -i ripgrep*.deb &&
    popd
fi
