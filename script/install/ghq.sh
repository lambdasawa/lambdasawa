#!/bin/bash

if ! which ghq >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install ghq
  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    curl -sSLO https://github.com/x-motemen/ghq/releases/download/v1.2.1/ghq_linux_amd64.zip &&
    unzip ghq_linux_amd64.zip &&
    mv ./ghq_linux_amd64/ghq ~/.local/bin/ &&
    popd
fi
