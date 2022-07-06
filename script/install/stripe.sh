#!/bin/bash

if ! which stripe >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install stripe/stripe-cli/stripe
  [ "$(uname)" = Linux ] && curl -sSL https://github.com/stripe/stripe-cli/releases/download/v1.7.8/stripe-linux-checksums.txt >/usr/local/bin/stripe && chmod u+x /usr/local/bin/stripe
fi
