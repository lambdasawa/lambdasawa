#!/bin/bash

mkdir -p ~/.raycast-script-commands
pushd "$PWD" || exit
cd ~/.raycast-script-commands || exit
for url in \
  https://raw.githubusercontent.com/raycast/script-commands/master/commands/system/audio/set-audio-device.swift \
  https://raw.githubusercontent.com/raycast/script-commands/master/commands/system/flush-dns.sh \
  https://raw.githubusercontent.com/raycast/script-commands/master/commands/communication/slack/slack-jump-to.applescript \
  https://raw.githubusercontent.com/raycast/script-commands/master/commands/conversions/vaporwave-text.sh \
  https://raw.githubusercontent.com/raycast/script-commands/master/commands/conversions/zalgo-text.swift; do
  curl -sSLO $url
done
chmod u+x ./*
popd || exit
