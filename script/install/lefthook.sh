#!/bin/bash

if ! which lefthook >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install Arkweid/lefthook/lefthook
  [ "$(uname)" = Linux ] &&
    curl -1sLf 'https://dl.cloudsmith.io/public/evilmartians/lefthook/setup.deb.sh' | sudo -E bash &&
    sudo apt install -yqq lefthook
fi
