source ~/.zsh/history.zsh
source ~/.zsh/plugins.zsh
source ~/.zaliases
source ~/.zsh/prompt.zsh

alias c='git --git-dir=$HOME/dotfiles --work-tree=$HOME'

bindkey '^R' history-incremental-search-backward
bindkey -M viins '\e' vi-cmd-mode
bindkey '^O' edit-command-line
bindkey -M vicmd '^O' edit-command-line
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey '^ ' autosuggest-accept # ctl-space
bindkey -M vicmd "H" beginning-of-line
bindkey -M vicmd "L" end-of-line
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -v '^?' backward-delete-char

export TOUCHBAR_GIT_ENABLED=false

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

function {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  local func_glob='^(.*)(-.N:t)'
  for func in ${ZDOTDIR:-$HOME}/.zsh/functions/$~func_glob; do
    autoload -Uz "$func"
  done
}

function git() {
  if [[ "${PWD}" == "${HOME}" ]]; then
    if [[ "$1" == "clean" ]]; then
      >&2 echo "Do NOT run git clean in this repository."
      return
    fi
    export GIT_DIR=$HOME/dotfiles/
    export GIT_WORK_TREE=$HOME
    export FZF_DEFAULT_COMMAND="git ls-files"
  else
    unset GIT_DIR
    unset GIT_WORK_TREE
    export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/*'"
  fi
  command git "$@"
}

[ -f "/Users/tball/.shopify-app-cli/shopify.sh" ] && source "/Users/tball/.shopify-app-cli/shopify.sh"
