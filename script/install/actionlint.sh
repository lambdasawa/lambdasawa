#!/bin/bash

if ! which actionlint >/dev/null 2>&1; then
  go install github.com/rhysd/actionlint/cmd/actionlint@latest
fi
