#!/bin/bash

if ! which trans >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install translate-shell
  [ "$(uname)" = Linux ] && sudo apt install -yqq translate-shell
fi
