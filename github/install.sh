#!/bin/bash

set -ex

git config --global user.name "Brian Anglin"
git config --global user.email "brianranglin+gh@gmail.com"

if [ ! -d ~/moonlight/kb ]
then
  git clone git@github.com:anglinb/kb.git ~/moonlight/kb
fi

