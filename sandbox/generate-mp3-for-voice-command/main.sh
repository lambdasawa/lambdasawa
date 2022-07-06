#!/bin/bash

set -xeuo pipefail

# https://github.com/lambdasawa/dotfiles/blob/8ab7689467/bin/voice

youtube-dl --extract-audio --audio-format mp3 "https://www.youtube.com/clip/Ugkx5n5SqNixqMYwI3CnzMUeW--FlbvXnjfm"
sox data.mp3 success.mp3 trim 29:38 1 && mpv success.mp3
sox data.mp3 failure.mp3 trim 1:13:57.2 1 && mpv failure.mp3
mkdir -p ~/.voice
mv success.mp3 failure.mp3 ~/.voice/
