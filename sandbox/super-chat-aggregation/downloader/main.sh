#!/bin/bash

set -xeuo pipefail

yt-dlp --concurrent-fragments 8 --downloader aria2c --write-subs --no-download "${1:?}"
