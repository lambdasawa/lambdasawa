#!/bin/bash

if ! which fd >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install fd
  [ "$(uname)" = Linux ] && sudo apt install -yqq fd-find
fi
