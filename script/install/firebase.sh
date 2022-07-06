#!/bin/bash

if ! which firebase >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install firebase-cli
  [ "$(uname)" = Linux ] && curl -sL https://firebase.tools | bash
fi
