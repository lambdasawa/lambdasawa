#!/bin/bash

if ! which curry >/dev/null 2>&1; then
  brew tap lambdasawa/tap
  brew install lambdasawa/tap/curry
fi
