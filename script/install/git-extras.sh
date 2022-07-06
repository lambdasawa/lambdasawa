#!/bin/bash

if ! which git-abort >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install git-extras
  [ "$(uname)" = Linux ] && sudo apt-get install git-extras
fi
