#!/bin/bash

if ! which rip >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install rm-improved
  [ "$(uname)" = Linux ] && curl -sSLO https://github.com/nivekuil/rip/releases/download/0.12.0/rip && chmod u+x rip && mv rip ~/bin/
fi
