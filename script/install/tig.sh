#!/bin/bash

if ! which tig >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install tig
  [ "$(uname)" = Linux ] && sudo apt install -yqq tig
fi
