#!/bin/bash

if ! which openapi >/dev/null 2>&1; then
  npm i -g @redocly/cli
fi
