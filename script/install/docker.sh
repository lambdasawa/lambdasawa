#!/bin/bash

if ! which docker >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install --cask docker
  [ "$(uname)" = Linux ] && sudo apt install -yqq docker.io
fi
