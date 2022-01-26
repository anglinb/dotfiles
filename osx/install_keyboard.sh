#!/bin/bash

set -ex

if [ ! -d ~/.keyboard ]; then
    git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard
fi

cd ~/.keyboard
script/setup