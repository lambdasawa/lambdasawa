#!/bin/bash

if ! which eb >/dev/null 2>&1; then
  pip install awsebcli --upgrade --user
fi
