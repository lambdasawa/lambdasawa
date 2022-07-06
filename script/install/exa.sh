#!/bin/bash

if ! which exa >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install exa
  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    curl -sSLO https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip &&
    unzip exa-linux-x86_64-v0.10.1.zip &&
    mv ./bin/exa ~/.local/bin/ &&
    popd
fi
