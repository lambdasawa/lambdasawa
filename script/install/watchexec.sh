#!/bin/bash

if ! which watchexec >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install watchexec
  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    curl -sSLO https://github.com/watchexec/watchexec/releases/download/cli-v1.17.1/watchexec-1.17.1-x86_64-unknown-linux-gnu.deb &&
    sudo dpkg -i watchexec-1.17.1-x86_64-unknown-linux-gnu.deb &&
    popd
fi
