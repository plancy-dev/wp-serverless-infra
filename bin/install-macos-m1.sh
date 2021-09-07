#!/bin/bash

echo 'installing brew packages'
arch -arm64 brew update
arch -arm64 brew tap liamg/tfsec
arch -arm64 brew install tfenv tflint terraform-docs pre-commit liamg/tfsec/tfsec coreutils
arch -arm64 brew upgrade tfenv tflint terraform-docs pre-commit liamg/tfsec/tfsec coreutils

echo 'installing pre-commit hooks'
pre-commit install

echo 'setting pre-commit hooks to auto-install on clone in the future'
git config --global init.templateDir ~/.git-template
pre-commit init-templatedir ~/.git-template

echo 'installing terraform with tfenv'
tfenv install min-required
tfenv use min-required
