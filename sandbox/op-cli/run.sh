#!/bin/bash

set -xeuo pipefail

[ ! -e .env ] && cp .env.sample .env

op run --env-file=.env --no-masking -- printenv HOGE
