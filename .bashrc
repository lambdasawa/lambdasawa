#!/bin/bash

# shellcheck source=/dev/null

export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

if [ -e opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v asdf >/dev/null 2>&1; then
  [ -e "$(brew --prefix asdf)/libexec/asdf.sh" ] && . "$(brew --prefix asdf)/libexec/asdf.sh"
  [ -e ~/.asdf/asdf.sh ] && . ~/.asdf/asdf.sh
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi
