#!/bin/bash

set -xeuo pipefail

name=$(basename "${BASH_SOURCE[@]}" .sh)

jq -n -f "./tfmigrate/template/$name.jq" | tee "./tfmigrate/json/$name.json"
