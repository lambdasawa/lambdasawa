#!/bin/bash

set -xeuo pipefail

[ ! -e .env ] && cp .env.template .env

op run --env-file=.env --no-masking -- printenv HOGE
