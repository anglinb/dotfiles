#!/bin/bash

which -s brew 2>&1 > /dev/null
if [ $? -ne 0 ]
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

