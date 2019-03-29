BASE16_SHELL=$ZPLUG_REPOS/chriskempson/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

SPACESHIP_VI_MODE_INSERT='↪'
SPACESHIP_VI_MODE_NORMAL='⎋'
SPACESHIP_VI_MODE_COLOR='grey'
SPACESHIP_GIT_STATUS_COLOR='grey'
SPACESHIP_GIT_SYMBOL='ᛋ '

function spaceship_thaw() {
  thaw="$(git log -2 --format="%s" 2> /dev/null | grep -E "WIP \[\w+\]")"
  local thaw_status
  if [[ -n "$thaw" ]]; then
    thaw_status=true
  else
    return
  fi

  spaceship::section \
    "grey" \
    "*frozen*" \
}

local neworder=()
for item in $SPACESHIP_PROMPT_ORDER; do
  if [[ $item == 'line_sep' ]]; then
    neworder+=(thaw $item)
  else
    neworder+=($item)
  fi
done

SPACESHIP_PROMPT_ORDER=($neworder)
