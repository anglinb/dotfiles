#!/usr/bin/env python

import os
import shutil

BLACK_LIST = set([
   'install.sh',
   '.installed',
   '.backup'
])

USER_HOME = os.path.expanduser('~/')

def copy(src, dst):
    if os.path.isfile(src):
        if os.path.islink(src):
            linkto = os.readlink(src)
            os.symlink(linkto, dst)
        else:
            shutil.copy(src,dst)

def silentremove(filename):
    try:
        os.remove(filename)
    except OSError as e: # this would be "except OSError, e:" before Python 2.6
        if e.errno != errno.ENOENT: # errno.ENOENT = no such file or directory
            raise # re-raise exception if a different error occured

# Open the currently installed
to_unlink = []
if os.path.isfile('.installed'):
    with open('.installed', 'r+') as f:
        to_unlink = [x.strip() for x in f.readlines()]

if os.path.exists('.backup'):
    shutil.rmtree('.backup')
os.makedirs('.backup')

# Move each link to the backup
for line in to_unlink:
    home_path = os.path.join(USER_HOME, line)
    copy(home_path, os.path.join('.backup', line))
    silentremove(home_path)

to_link = filter(lambda x: x.strip() not in BLACK_LIST, os.listdir('.'))
for line in to_link:
    print "Linking "+os.path.abspath(line)+"  "+os.path.join(USER_HOME, line)
    os.symlink(os.path.abspath(line), os.path.join(USER_HOME, line))

with open('.installed', 'w+') as f:
    f.write('\n'.join(to_link))

