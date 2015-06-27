#
# Sets Oh My Zsh options.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# if we're using zsh, were local
export LOCATION='local'

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    source $HOME/.zaliases
fi

# load some custom completions
fpath=(${HOME}/.zsh/completions $fpath)
autoload -U compinit
compinit

bindkey '^R' history-incremental-search-backward
bindkey -M viins 'kj' vi-cmd-mode
bindkey '^O' edit-command-line

rename-tmux-window() {
  if [[ $PWD == $HOME ]]; then
    tmux rename-window '~'
  else
    tmux rename-window `echo $PWD | sed 's/.*\/\(.*\)/\1/'`
  fi
}

if [[ -n $TMUX ]]; then
  autoload -U add-zsh-hook
  add-zsh-hook chpwd rename-tmux-window
  rename-tmux-window
fi

if [[ -s "/etc/profile.d/chruby.sh" ]]; then
  # shopify's chruby script
  source /etc/profile.d/chruby.sh
fi
