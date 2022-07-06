#!/bin/bash

if ! which starship >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install starship
  [ "$(uname)" = Linux ] && FORCE=1 sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi
