Dot files repo
==============

Idea from http://linuxfr.org/nodes/105468/comments/1599434

The ```$HOME``` is a git work tree, but the ```.git``` (the git database) is not in the
```$HOME``` directory, but in the ```.sync``` directory.

git work has to be done with an alias that define where to find the .git
directory.

```sh
alias .git="GIT_DIR=~/.sync/.git git"
```

To clone into a new home

```sh
git clone --recursive https://github.com/Nimlar/dotfiles.git ~/.sync; cd ~/.sync; ./.config/git/init-sync
```

After the clone, ```init-sync``` will move the files to the ```$HOME```
directory, update the submodules, and configure the ```.sync/.git``` database to use
```$HOME``` as the worktree

