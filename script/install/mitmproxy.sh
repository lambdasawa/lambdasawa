#!/bin/bash

if ! which mitmproxy >/dev/null 2>&1; then
  pip install mitmproxy --upgrade --user
fi
