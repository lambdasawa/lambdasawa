#!/bin/bash

if ! which zoxide >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install zoxide
  [ "$(uname)" = Linux ] && curl -sS https://webinstall.dev/zoxide | bash
fi
