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
brew bundle || true

# TODO: If we can check if we need this, then we should
# sudo xcodebuild -license accept

# Clean up all the garbage
brew cleanup

./install_keyboard.sh

# Install zsh
which -s zsh 2>&1 > /dev/null
if [ $? -ne 0 ]
then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install oh-my-zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "oh-my-zsh is already installed."
else
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install nvm
if ! command -v nvm &> /dev/null
then
	echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
else
	echo "nvm is already installed."
fi

# Make sure git will cache my password
git config --global credential.helper osxkeychain

# Setup git author
git config --global user.email "brianranglin@gmail.com"
git config --global user.name "Brian Anglin"
git config push.autoSetupRemote true # Make git push work


./osx_defaults.sh
