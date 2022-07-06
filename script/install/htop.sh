#!/bin/bash

if ! which htop >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install htop
  [ "$(uname)" = Linux ] && sudo apt install -yqq htop
fi
