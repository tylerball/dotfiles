dotfiles
========

This is a collection of configuration files that I use on all my computers and
an [ansible][ansible] playbook that installs them.

I use [this ingenious method][genius] for using my home directory like a git
repository.

Install
-------

```sh
curl -Lks https://raw.githubusercontent.com/tylerball/dotfiles/master/clone | zsh
./install.sh
```

----

Thanks to
---------

* [Mathias Bynens](https://github.com/mathiasbynens) and his [.osx file](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)
* [Mnemonikk](http://mnemonikk.org/2009/03/23/finally-putting-my-personal-configuration-files-under-version-control/)

[ansible]:https://github.com/ansible/ansible
[packages]:https://github.com/tylerball/dotfiles/blob/master/roles/mac/defaults/main.yml
[genius]:https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
