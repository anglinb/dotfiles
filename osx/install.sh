#!/bin/bash

set -e

cd "$(dirname "$0")"

# Install homebrew
./install_homebrew.sh

# Make sure we always eval homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update
brew upgrade

# Install from Brewfile
brew bundle

# Clean up all the garbage
brew cleanup

./install_keyboard.sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Make sure git will cache my password
git config --global credential.helper osxkeychain
