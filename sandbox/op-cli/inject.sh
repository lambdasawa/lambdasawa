#!/bin/bash

set -xeuo pipefail

op inject -i config.tmpl.yml -o config.yml
