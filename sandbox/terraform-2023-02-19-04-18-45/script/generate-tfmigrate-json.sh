#!/bin/bash

set -xeuo pipefail

rm -rf tfmigrate/json/
mkdir -p tfmigrate/json/

for jq_file in $(find tfmigrate/template -type f); do

  filename=$(basename $jq_file .jq).json
  output_path="tfmigrate/json/$filename"

  jq -n -f "$jq_file" | tee "$output_path"

done
