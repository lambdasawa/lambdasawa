#!/bin/bash

if ! which dot >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install graphviz
  [ "$(uname)" = Linux ] && sudo apt install -yqq graphviz
fi
