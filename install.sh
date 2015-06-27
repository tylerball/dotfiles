#!/usr/bin/env bash
if [[ -x `which brew` ]]; then
  brew update 2>&1
  brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup 2>&1
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

ansible-playbook site.yml
