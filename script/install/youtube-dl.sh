#!/bin/bash

if ! which youtube-dl >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install youtube-dl
  [ "$(uname)" = Linux ] && sudo apt install -yqq youtube-dl
fi
