#!/bin/bash

if ! which scrcpy >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install scrcpy
  [ "$(uname)" = Linux ] && sudo apt install -yqq scrcpy
fi
