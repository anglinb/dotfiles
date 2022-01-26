#!/bin/bash

set -e

cd "$(dirname "$0")"

# Install homebrew
./install_homebrew.sh

brew update
brew upgrade --all

# Install from Brewfile
brew bundle

# Clean up all the garbage
brew cleanup

./install_keyboard.sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make sure git will cache my password
git config --global credential.helper osxkeychain
