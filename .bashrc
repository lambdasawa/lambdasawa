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

if which code >/dev/null 2>&1; then
  export EDITOR="code --wait"
elif which vim >/dev/null 2>&1; then
  export EDITOR=vim
fi

if [ -e /usr/libexec/java_home ]; then
  java_home=$(/usr/libexec/java_home -v 1.8.0 >/dev/null 2>&1)
  export JAVA_HOME=$java_home
fi
if [ -e ~/Library/Android/sdk ]; then
  export ANDROID_HOME=~/Library/Android/sdk
fi
if [ -e $ANDROID_HOME/emulator ]; then
  export PATH="$PATH:$ANDROID_HOME/emulator"
fi
if [ -e $ANDROID_HOME/tools ]; then
  export PATH="$PATH:$ANDROID_HOME/tools"
fi
if [ -e $ANDROID_HOME/tools/bin ]; then
  export PATH="$PATH:$ANDROID_HOME/tools/bin"
fi
if [ -e $ANDROID_HOME/platform-tools ]; then
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
fi

cd() {
  d="$*"
  if [ -z "$*" ]; then
    d=$(find . -type d | filter)
  fi

  builtin cd "$d" || exit
  list || ls
}

rm() {
  if command -v gomi >/dev/null 2>&1; then
    gomi "$@"
  else
    builtin rm "$@"
  fi
}

mcd() {
  mkdir -p "$@"
  cd "$@" || exit
}

alias a="amplify"
alias b="clipboard"
alias c="docker compose"
alias d="docker"
alias e="edit"
alias f="filter"
alias g="git-wrapper"
alias h="curlie"
alias i="checkip"
alias j="jq"
alias k="kubectl"
alias l="list"
alias m="make"
alias n="noti"
alias o="open"
alias p="python"
alias q="exit"
alias r="repeat"
alias s="show"
alias t="tmuxselect"
alias u="update"
alias v="asdf"
alias w="watchexec"
alias x="exec bash"
alias y="yarn"
# z used by zoxide
alias X="xargs"
alias ae="aws-vault exec"
alias de="docker exec"
alias ce="docker compose exec"
alias ee="direnv exec ."
alias be="bundle exec"
alias ne="npm run"
alias ta="tmux attach || tmux"
alias to="tmuxopen"
alias hi="selecthis"
alias apw="amplify env pull && amplify push -y && noti 'amplify hotswap ready!' && amplify amplify-function-hotswap-plugin watch"
alias cdk1="npx aws-cdk@1.x"
alias cdk="npx aws-cdk@2.x"

BeforeCmd() {
  if [ "$1" = __zoxide_hook ] || [ "$1" = _direnv_hook ] || [ "$1" = starship_precmd ] || [ "$1" = AfterCmd ]; then
    return
  fi
  if echo "$*" | grep "^PROMPT_COMMAND=" >/dev/null; then
    return
  fi

  echo "BeforeCmd $*"
}
# trap 'BeforeCmd $BASH_COMMAND' DEBUG

AfterCmd() {
  echo "AfterCmd $*"
}
# PROMPT_COMMAND="$PROMPT_COMMAND;"'AfterCmd $BASH_COMMAND'

selecthis() {
  l=$(history | sed -E 's/^[ 0-9]+//' | tac | filter)
  READLINE_LINE="$l"
  READLINE_POINT="${#l}"
}
bind -x '"\C-r": selecthis'

EditCommandBuffer() {
  f=$(mktemp)
  echo "$READLINE_LINE" >"$f"
  $EDITOR "$f"
  l=$(cat "$f")
  READLINE_LINE="$l"
  READLINE_POINT="${#l}"
  rm "$f"
}
bind -x '"\ee": EditCommandBuffer'
