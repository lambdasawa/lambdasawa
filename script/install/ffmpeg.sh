#!/bin/bash

if ! which ffmpeg >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install ffmpeg
  [ "$(uname)" = Linux ] && sudo apt install -yqq ffmpeg
fi
