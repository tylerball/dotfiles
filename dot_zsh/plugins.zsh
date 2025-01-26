export PLUGIN_HOME=$HOME/.zsh/plugins

function plugin() {
  local name=$1
  local dir="$PLUGIN_HOME/$name"
  local plugfile=($dir/*.plugin.zsh(N))
  plugfile+=($dir/init.sh(N))
  if [[ -n $2 && -f "$dir/$2" ]]; then
    source "$dir/$2"
    return
  fi
  if (( ${#plugfile[@]} )); then
    source $plugfile
  fi
}

export BASE16_SCHEME="material-darker"
export FZF_DEFAULT_OPTS='--bind ctrl-d:page-down,ctrl-u:page-up'
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export SPACESHIP_ROOT="$PLUGIN_HOME/spaceship-prompt"

zle -N history-substring-search-up
zle -N history-substring-search-down

autoload -Uz compinit
compinit

plugin "zsh-autoenv"
plugin "k"
plugin "zsh-autosuggestions"
plugin "zsh-completions"
plugin "base16-shell"
plugin "zsh-vim-mode"
plugin "zsh-syntax-highlighting"
plugin "zsh-history-substring-search"
plugin "fzf" "shell/key-bindings.zsh"
plugin "spaceship-prompt" "spaceship.zsh"
