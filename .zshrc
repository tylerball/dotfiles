HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
unsetopt ignoreeof # allow exiting from shell with ctrl+d

source ~/.zplugs
source ~/.zaliases
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

export FZF_COMPLETION_TRIGGER='~~'

export TOUCHBAR_GIT_ENABLED=false

BASE16_SHELL=$ZPLUG_REPOS/chriskempson/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export FZF_DEFAULT_OPTS='--bind ctrl-d:page-down,ctrl-u:page-up'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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

autoload -Uz promptinit
fpath=($fpath ~/.zplug/repos/BrandonRoehl/zsh-clean)
promptinit
prompt clean 256

zstyle ':vcs_info:git:thaw' thawformat " *frozen*"

function prompt_thaw_precmd () {
  thaw="$(git log -2 --format="%s" 2> /dev/null | grep -E "WIP \[\w+\]")"
  if [[ -n "$thaw" ]]; then
    local thaw_formatted
    zstyle -s ':vcs_info:git:thaw' thawformat thaw_formatted
    psvar[2]+=$thaw_formatted
  fi
}

add-zsh-hook precmd prompt_thaw_precmd
