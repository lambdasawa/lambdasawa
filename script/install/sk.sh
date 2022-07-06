#!/bin/bash

if ! which sk >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install sk
  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    curl -sSLO https://github.com/lotabout/skim/releases/download/v0.9.4/skim-v0.9.4-x86_64-unknown-linux-musl.tar.gz &&
    tar zxvf skim-v0.9.4-x86_64-unknown-linux-musl.tar.gz &&
    mv ./sk ~/.local/bin/ &&
    popd
fi
