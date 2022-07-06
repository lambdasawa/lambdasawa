#!/bin/bash

for path in \
  .bashrc \
  .zshrc \
  .vimrc \
  .gitconfig \
  .config/git/* \
  .config/gh/config.yml \
  .config/fish/* \
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
