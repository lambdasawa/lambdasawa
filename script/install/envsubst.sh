#!/bin/bash

if ! which envsubst >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install gettext
  [ "$(uname)" = Linux ] && sudo apt install -yqq gettext-base
fi
