#!/bin/bash

if ! which delta >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install git-delta
  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    curl -sSL https://github.com/dandavison/delta/releases/download/0.12.1/git-delta_0.12.1_amd64.deb >~/tmp/delta.deb &&
    sudo dpkg -i ~/tmp/delta.deb &&
    popd
fi
