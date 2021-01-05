#!/bin/bash

# Install homebrew
echo "Installing homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# Upgrade all packages
brew upgrade --all

# Tools
brew install tmux
brew install postgres
brew install node
brew install nodenv
brew install rbenv
brew install watchman
brew install terraform
brew install awscli
brew install pyenv-virtualenv

# Security
brew install gpg2

# Core functionality Apps
brew cask install --appdir="/Applications" macvim
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" skitch
brew cask install --appdir="/Applications" hammerspoon
brew cask install --appdir="/Applications" graphiql

# Must have non-dev
brew cask install --appdir="/Applications" spotify

# Clean up all the garbage
brew cleanup

echo "Tweaking Apple Settings"

# TODO: Add default trackpad setting
# defaults read com.apple.AppleMultitouchTrackpad

#Enable repeat on keydown
defaults write -g ApplePressAndHoldEnabled -bool false

#Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

#Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

#Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

#Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0.02

#Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12

#Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

#Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#Show the ~/Library folder
chflags nohidden ~/Library


git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard

cd ~/.keyboard
script/setup
