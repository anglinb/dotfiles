#!/bin/bash

set -e

cd "$(dirname "$0")"

# Install homebrew
./install_homebrew.sh

# Make sure we always eval homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update
brew upgrade
brew services

# Install from Brewfile
brew bundle

# Clean up all the garbage
brew cleanup

./install_keyboard.sh

# Install oh-my-zsh
which -s zsh 2>&1 > /dev/null
if [ $? -ne 0 ]
then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install nvm
which -s nvm 2>&1 > /dev/null
if [ $? -ne 0 ]
then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi


# Make sure git will cache my password
git config --global credential.helper osxkeychain

./osx_defaults.sh
