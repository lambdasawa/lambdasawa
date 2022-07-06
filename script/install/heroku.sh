#!/bin/bash

if ! which heroku >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew tap heroku/brew && brew install heroku
  [ "$(uname)" = Linux ] && sudo snap install --classic heroku
fi
