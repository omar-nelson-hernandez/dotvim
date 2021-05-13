#!/usr/bin/env bash

echo "Installing nvim config"

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

ln -s ${SCRIPTPATH} ~/.config/nvim

echo "Installed nvim config"
