#!/bin/bash

if ! which sls >/dev/null 2>&1; then
  npm i -g serverless
fi
