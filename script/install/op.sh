#!/bin/bash

if ! which tig >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install --cask 1password/tap/1password-cli
  [ "$(uname)" = Linux ] &&
    ARCH="amd64" &&
    wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.0.0/op_linux_${ARCH}_v2.0.0.zip" -O op.zip &&
    unzip -d op op.zip &&
    sudo mv op/op /usr/local/bin &&
    rm -r op.zip op
fi
