#!/bin/bash

if ! which sox >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install sox
  [ "$(uname)" = Linux ] && sudo apt install -yqq sox
fi
