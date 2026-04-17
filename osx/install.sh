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

# Accept Xcode license if not already accepted
if ! xcodebuild -license check &> /dev/null; then
	echo "Accepting Xcode license..."
	sudo xcodebuild -license accept
fi

# Clean up all the garbage
brew cleanup

./install_keyboard.sh
./install_vimplug.sh

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

# Uninstall nvm if present
if [ -d "$HOME/.nvm" ]; then
	echo "Removing nvm..."
	rm -rf "$HOME/.nvm"
fi

# Install Volta
if command -v volta &> /dev/null; then
	echo "Volta is already installed."
else
	echo "Installing Volta..."
	curl https://get.volta.sh | bash
fi

# Install Claude Code
./install_claude.sh

# Install Claude Code skills
./install_skills.sh

# Set up App Store Connect (asc) auth (from private repo)
../private/install_asc.sh

# Install Kanna
if command -v kanna &> /dev/null; then
	echo "Kanna is already installed."
else
	echo "Installing Kanna..."
	bun install -g kanna-code
fi

# Make sure git will cache my password
git config --global credential.helper osxkeychain

# Setup git author
git config --global user.email "brianranglin@gmail.com"
git config --global user.name "Brian Anglin"
git config push.autoSetupRemote true # Make git push work


./osx_defaults.sh
