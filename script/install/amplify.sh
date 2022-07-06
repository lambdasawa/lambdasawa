#!/bin/bash

if ! which amplify >/dev/null 2>&1; then
  npm i -g @aws-amplify/cli amplify-function-hotswap-plugin
fi
