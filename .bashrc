export EDITOR=vim

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# allow for advanced globbing
shopt -s extglob

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# UI
# --
# Use vi key bindings
set -o vi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Colours and Command line
# ------------------------

function fgcolor {
    echo "\\[\\033[38;5;"$1"m\\]"
    }

function boldtext {
    echo "\\[\\033[1m\\]"$1"\\[\\033[0m\\]"
    }
function resetcolor {
    echo "\\[\\e[0m\\]"
    }

#colour in OS X
export CLICOLOR=2
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

PS1="${debian_chroot:+($debian_chroot)}$(fgcolor 172)\h$(resetcolor) $(boldtext :) $(fgcolor 111)\w$(fgcolor 7)\$(__git_ps1 '$(resetcolor) $(boldtext :) $(fgcolor 154)(%s)')$(fgcolor 7) $ "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Enable bash and git completion
if [[ "$(uname)" = "Darwin" ]]; then
    . `brew --prefix`/etc/bash_completion && . `brew --prefix`/etc/bash_completion.d/git-completion.bash
else
    if [ -d /etc/bash_completion ]; then
        . /etc/bash_completion
        source /etc/bash_completion.d/git
    fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
