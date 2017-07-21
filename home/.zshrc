unsetopt ignoreeof          # allow exiting from shell with ctrl+d

[ -f "${ZDOTDIR:-$HOME}/.zplug/init.zsh" ] && source ~/.zplugs
[ -f "${ZDOTDIR:-$HOME}/.zaliases" ] && source $HOME/.zaliases

zmodload zsh/terminfo
bindkey '^R' history-incremental-search-backward
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins '\e' vi-cmd-mode
bindkey '^O' edit-command-line
bindkey -M vicmd '^O' edit-command-line
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey '^ ' autosuggest-accept # ctl-space
bindkey -M vicmd "H" beginning-of-line
bindkey -M vicmd "L" end-of-line
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcub1]" history-substring-search-down

if [[ -s "/etc/profile.d/chruby.sh" ]]; then
  # shopify's chruby script
  source /etc/profile.d/chruby.sh
fi

export FZF_COMPLETION_TRIGGER='~~'

export ENHANCD_FILTER='fzf'
export ENHANCD_DOT_SHOW_FULLPATH=1

export NVM_DIR='' # wtf

BASE16_SHELL=$ZPLUG_REPOS/chriskempson/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export FZF_DEFAULT_OPTS='--bind ctrl-d:page-down,ctrl-u:page-up'
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/*'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

function {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  local func_glob='^(.*|prompt_*_setup)(-.N:t)'
  for func in ${ZDOTDIR:-$HOME}/.zsh/functions/$~func_glob; do
    autoload -Uz "$func"
  done
}

export PATH="$HOME/.yarn/bin:$PATH"
