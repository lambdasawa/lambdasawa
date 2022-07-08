#!/bin/bash

set -euo pipefail

curl -sSL https://aogirihighschool.com/ | pup 'meta[property="og:image"], meta[property="og:url"] json{}' | jq -r '.[] | .content'

curl -sSL "https://aogirihighschool.com/$(curl -sSL https://aogirihighschool.com/ | pup '.mainvisual attr{src}')" | identify /dev/stdin
