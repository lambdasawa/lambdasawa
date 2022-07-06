#!/bin/bash

if ! which direnv >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install direnv
  [ "$(uname)" = Linux ] && sudo apt install -yqq direnv
fi
