#!/bin/bash

if ! which gron >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install gron
  [ "$(uname)" = Linux ] && sudo apt install -yqq gron
fi
