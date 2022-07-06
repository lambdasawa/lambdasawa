#!/bin/bash

if ! which sponge >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install moreutils
  [ "$(uname)" = Linux ] && sudo apt install -yqq moreutils
fi
