echo "Welcome to zsh."


if [ -e opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
. /opt/homebrew/opt/asdf/libexec/asdf.sh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

if which code 2>&1 >/dev/null; then
  export EDITOR="code --wait"
elif which vim 2>&1 >/dev/null; then
  export EDITOR=vim
fi
