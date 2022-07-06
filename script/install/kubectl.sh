#!/bin/bash

if ! which kubectl >/dev/null 2>&1; then
  [ "$(uname)" = Darwin ] && brew install kubectl
  [ "$(uname)" = Linux ] &&
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" &&
    chmod +x ./kubectl &&
    sudo mv ./kubectl /usr/local/bin/kubectl
fi
