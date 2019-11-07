# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes bin folder under hosting
if [ -d "$HOME/hosting/bin" ] ; then
    PATH="$HOME/hosting/bin:$PATH"
fi

umask 0002

alias runserver='./manage.py runserver 0:8000'
alias macmount='sudo mount -t vboxsf -o rw,uid=1000,gid=1000 mac /home/tball/mac'
export PATH="$HOME/.cargo/bin:$PATH"
if [ -e /Users/tball/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tball/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
