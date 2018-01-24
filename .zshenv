[[ $- == *i* ]] && stty -ixon # disable terminal halting

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

if [[ -x `which nvim` ]]; then
  export EDITOR='nvim'
  export VISUAL='nvim'
fi
export PAGER='less'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $HOME/bin
  $HOME/.bin
  ./node_modules/.bin
  $path
)

export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi

fpath=(~/.zsh/functions $fpath)

if (( $+commands[yarn] )); then
  export PATH="$(yarn global dir)/node_modules/.bin:$PATH"
fi
