#!/bin/python

import os

USER_HOME = os.path.expanduser('~/')

def main():
    with open('links.txt', 'rb') as f:
        lines = [x.strip() for x in f.readlines()]

    for line in lines:

        src = os.path.abspath(os.path.join("env/bin",line))
        dest = os.path.join("../bin", line)
        print "src: "+src + " dest: " + dest
        if not os.path.isfile(dest):
            os.symlink(src, dest)

main()
