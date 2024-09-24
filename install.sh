#!/bin/bash

set -e

cd "$(dirname "$0")"

PLATFORM="";
if [ "$(uname)" == "Darwin" ]; then
    PLATFORM="osx"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    PLATFORM="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	PLATFORM="dos"
fi

if [ -z "$PLATFORM" ]; then
	echo "Unable to determine platform. Define explictly with PLATFORM=\"osx/linux/dos\" ./install.sh"
	exit 1
fi

# Setup some common folders

mkdir -p ~/moonlight  2>&1 > /dev/null
mkdir -p ~/superwall  2>&1 > /dev/null

# Commands that I don't know where to put yet...
# mkdir -p bin
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

if [ "$PLATFORM" == "osx" ]; then
	# Install osx tweaks (and homebrew)
	cd osx && ./install.sh
	cd ..
fi

cd dotfiles && ./install.sh
cd ..

# Finish setup
vim +PluginInstall +qall
