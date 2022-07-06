#!/bin/bash

if ! which shellcheck >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install shellcheck
  [ "$(uname)" = Linux ] && sudo apt install -yqq shellcheck
fi
