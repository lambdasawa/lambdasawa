#!/bin/bash

if ! which adb >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install --cask android-platform-tools
  [ "$(uname)" = Linux ] && sudo apt install -yqq android-tools-adb
fi
