dotfiles
========

This is a collection of configuration files that I use on all my computers and
an [ansible][ansible] playbook that installs them.

### What's included

* Homebrew packages and cask apps as defined [here][packages].

* I use a [homebrew formula][homebrew-macvim] to install the latest macvim
possible, compiled with ruby and python support.

* I also use Sorin Ionescu's [Prezto][prezto] for configuring zsh.

Install
-------

1. git clone this repo somewhere __other than your home directory__.
2. `./install.sh`

----

Thanks to
---------

* [Mathias Bynens](https://github.com/mathiasbynens) and his [.osx file](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)
* [Mnemonikk](http://mnemonikk.org/2009/03/23/finally-putting-my-personal-configuration-files-under-version-control/)

[ansible]:https://github.com/ansible/ansible
[packages]:https://github.com/tylerball/dotfiles/blob/master/roles/common/defaults/main.yml
[homebrew-macvim]: https://github.com/tylerball/homebrew-macvim
[prezto]: https://github.com/sorin-ionescu/prezto
[neobundle]: https://github.com/Shougo/neobundle.vim
[gerardo]: https://github.com/gerardo
[gers]: https://github.com/gerardo/dotfiles/blob/master/install.sh
