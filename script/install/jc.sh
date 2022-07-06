#!/bin/bash

if ! which jc >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install jc
  [ "$(uname)" = Linux ] && pip3 install jc
fi
