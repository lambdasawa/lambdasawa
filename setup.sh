#!/bin/bash

bin() {
  for name in ~/bin/*; do
    [ ! -e "$name" ] && rm "$name"
  done

  for name in ./bin/*; do
    chmod u+x "./$name"
    ln -sf "$PWD/$name" "$HOME/$name"
  done
}

symlink() {
  for path in \
    .bashrc \
    .zshrc \
    .vimrc \
    .gitconfig \
    .config/git/* \
    .config/gh/config.yml \
    .config/fish/* \
    .config/ongaku \
    .tigrc \
    .tmux.conf \
    .tool-versions \
    .default-npm-packages \
    .default-golang-pkgs \
    .default-cargo-crates \
    .default-python-packages \
    .default-gems \
    .config/starship.toml \
    .config/tridactyl; do
    if [ ! -e "$HOME"/$path ]; then
      mkdir -p "$(dirname ~/$path)"
      ln -sf "$PWD"/$path "$HOME"/$path
    fi
  done
}

basic() {
  if [ "$(uname)" = Darwin ]; then
    # install
    if ! command -v brew >/dev/null; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # update
    brew bundle
  fi

  if [ "$(uname)" = Linux ] && ! command -v apt >/dev/null; then
    sudo apt update -yqq
    sudo apt install -yqq fish git curl wget vim gcc sudo
  fi
}

asdf() {
  # install
  if ! command -v asdf >/dev/null; then
    if [ "$(uname)" = Darwin ]; then
      brew install asdf
    fi
    if [ "$(uname)" = Linux ] && ! command -v apt >/dev/null; then
      [ ! -e ~/.asdf ] && git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    fi
  fi

  # load
  if [ "$(uname)" = Darwin ]; then
    # shellcheck source=/dev/null
    . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
  fi
  if [ "$(uname)" = Linux ]; then
    # shellcheck source=/dev/null
    . "$HOME/.asdf/asdf.sh"
  fi

  # update
  asdf update
  asdf plugin update --all
  asdf install
}

main() {
  mkdir -p ~/.local/bin ~/bin ~/tmp ~/var ~/opt
  bin
  symlink
  basic
  asdf
}

main
