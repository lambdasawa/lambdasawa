#!/bin/bash

if ! which convert >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install imagemagick
  [ "$(uname)" = Linux ] && sudo apt install -yqq imagemagick
fi
