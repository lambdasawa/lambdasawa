#!/bin/bash

for name in ~/bin/*; do
  if [ ! -e "$name" ]; then
    rm "$name"
  fi
done

for name in bin/*; do
  mkdir -p ~/bin
  chmod u+x "$name"
  ln -sf "$PWD/$name" "$HOME/$name"
done
