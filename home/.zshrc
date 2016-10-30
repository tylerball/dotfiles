#
# Sets Oh My Zsh options.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# if we're using zsh, were local
export LOCATION='local'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "${ZDOTDIR:-$HOME}/.zplug/init.zsh" ] && source ~/.zplugs

unsetopt ignoreeof          # allow exiting from shell with ctrl+d
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt AUTO_NAME_DIRS       # Auto add variable-stored paths to ~ list.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000              # The maximum number of events to save in the internal history.
SAVEHIST=10000              # The maximum number of events to save in the history file.
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

fpath=(~/.zplug/repos/zsh-users/zsh-completions/src $fpath)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    source $HOME/.zaliases
    source $HOME/.zfunctions
fi

# load some custom completions
fpath=(${HOME}/.zsh/completions $fpath)
autoload -U compinit
compinit

bindkey '^R' history-incremental-search-backward
bindkey -M viins 'kj' vi-cmd-mode
bindkey '^O' edit-command-line
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey '^ ' autosuggest-accept # ctl-space
bindkey -M vicmd "H" beginning-of-line
bindkey -M vicmd "L" end-of-line
bindkey "$key_info[Up]" history-substring-search-up
bindkey "$key_info[Down]" history-substring-search-down

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

export FZF_COMPLETION_TRIGGER='~~'

local colourscheme=`cat ~/.colourscheme`
eval ${colourscheme}

# custom stuff
eval "$(fasd --init posix-alias zsh-hook)"

export NVM_DIR='' # wtf
export PATH=$PATH:./node_modules/.bin

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

BASE16_SHELL="$HOME/.zplug/repos/chriskempson/base16-shell/scripts/base16-default-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export PATH="$HOME/.yarn/bin:$PATH"
