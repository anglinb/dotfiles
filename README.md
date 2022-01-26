dotfiles
===

I finally decided to setup a dotfiles repo, mainly motivated by having to move
computers a few times recently. This is very WIP, try at your own risk.


## Install

    git clone https://github.com/anglinb/dotfiles ~/.dotfiles &&
    ~/.dotfiles/install.sh

## File Structure

    bin/ (Python build & random stuff gets linked here)
    cron/ (I had a cron job here but I accidentally deleted it... No clue what
    it was...)
    osx/ (OSX specific install)
        install.sh        (Sets a bunch of parameters specific to mac osx)
    tools/ (Build dir for tools)
        install.sh        (Build all to tools & link them to bin)
        link.py           (Could do this with shell script. Links files)
        links.txt         (What binaries to link)
        requirements.txt  (Python libs I want gobally like mitmproxyy)


## Todo

[] Setup auto-reverse ssh tunnel to bastion (http://blog.kylemanna.com/osx/2013/06/20/ssh-reverse-tunnel-on-mac-os-x/)
[] Add ProxyCommand to ssh.md
[] Setup complete Ctrl-(hjkl) movement for splits & tmux windows
