#!/usr/bin/env bash

# Make sure the config directory exists
mkdir -p ~/.config/nvim

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"/init.vim
LINK=~/.config/nvim/init.vim

echo "Creating a link to ${SCRIPTPATH} with name ${LINK}"

ln -s ${SCRIPTPATH} ${LINK}

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
LINK=~/.vim

echo "Creating a link to ${SCRIPTPATH} with name ${LINK}"

ln -s ${SCRIPTPATH} ${LINK}
