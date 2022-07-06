#!/bin/bash

if ! which ouch >/dev/null 2>&1; then
  curl -s https://raw.githubusercontent.com/ouch-org/ouch/master/install.sh | sh
fi
