#!/bin/bash

if ! which pandoc >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install pandoc
  [ "$(uname)" = Linux ] && sudo apt install -yqq pandoc
fi
