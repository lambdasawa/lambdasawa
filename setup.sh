#!/bin/bash

set -xeo pipefail

for name in home-dirs home-bin symlinks essential asdf; do
    bash -x "./script/setup-$name.sh"
done

for name in starship direnv zoxide watchexec sk exa bat rg hgrep delta fd rip ouch moreutils envsubst tig tmux gh git-extras ghq lefthook jc gron; do
    bash -x "./script/install/$name.sh"
done
