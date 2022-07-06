#!/bin/bash

if ! which noti >/dev/null 2>&1; then
  go install github.com/lambdasawa/noti@latest
fi
