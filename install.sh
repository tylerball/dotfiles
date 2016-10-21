#!/usr/bin/env bash
if [[ "$(uname)" = 'Darwin' ]]; then
  if [[ -x `which brew` ]]; then
    brew update 2>&1
    brew cleanup 2>&1
    brew doctor 2>&1
  else
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
  fi

  if [[ ! -x `which ansible` ]]; then
    echo "Installing ansible"
    brew install ansible 2>&1
  fi
else
  if [[ ! -x `which ansible` ]]; then
    echo "Installing ansible"
    sudo apt-get install software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install ansible
  fi
fi

ansible-playbook -c local site.yml

$HOME/.tmux/plugins/tpm/bin/update_plugins all
zplug update
