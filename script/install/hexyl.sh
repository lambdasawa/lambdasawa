#!/bin/bash

if ! which hexyl >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install hexyl
  [ "$(uname)" = Linux ] && sudo apt install -yqq hexyl
fi
