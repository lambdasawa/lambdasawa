#!/bin/bash

if ! which hgrep >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] &&
    brew tap "rhysd/hgrep" "https://github.com/rhysd/hgrep" &&
    brew install hgrep

  [ "$(uname)" = Linux ] &&
    pushd "$PWD" &&
    cd "$(mktemp -d)" &&
    curl -sSLO https://github.com/rhysd/hgrep/releases/download/v0.2.3/hgrep-v0.2.3-x86_64-unknown-linux-gnu.zip &&
    unzip hgrep-v0.2.3-x86_64-unknown-linux-gnu.zip &&
    mv ./hgrep-v0.2.3-x86_64-unknown-linux-gnu/hgrep ~/.local/bin/ &&
    rm -rf ./hgrep-v0.2.3-x86_64-unknown-linux-gnu &&
    popd
fi
