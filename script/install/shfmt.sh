#!/bin/bash

if ! which shfmt >/dev/null 2>&1; then
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
fi
