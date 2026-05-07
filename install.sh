#!/bin/bash

set -e

cd "$(dirname "$0")"

# Ask for sudo password upfront and keep the session alive
# until the install finishes
sudo -v
while true; do sudo -n true; sleep 10; kill -0 "$$" || exit; done 2>/dev/null &

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

# Clone (or update) private dotfiles
if [ -d private/.git ]; then
	git -C private pull --ff-only
else
	gh repo clone anglinb/dotfiles-private private
fi

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

# Clone (or update) the personal skills repo and run its installer to
# globally install all skills + extras listed in skills.txt.
SKILLS_REPO_URL="https://github.com/anglinb/skills.git"
SKILLS_REPO_DIR="$(pwd)/skills"
if [ -d "${SKILLS_REPO_DIR}/.git" ]; then
	echo "Updating ${SKILLS_REPO_URL}..."
	git -C "${SKILLS_REPO_DIR}" fetch --tags --prune origin
	git -C "${SKILLS_REPO_DIR}" reset --hard origin/HEAD 2>/dev/null || true
else
	echo "Cloning ${SKILLS_REPO_URL}..."
	git clone "${SKILLS_REPO_URL}" "${SKILLS_REPO_DIR}"
fi
"${SKILLS_REPO_DIR}/install.sh"

# Install vim plugins
vim +PlugInstall +qall
