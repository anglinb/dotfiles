#!/bin/bash

set -e

if [ ! -d ~/.keyboard ]; then
    git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard
fi

cd ~/.keyboard
script/setup