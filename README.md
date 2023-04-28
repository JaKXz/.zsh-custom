# my `$ZSH_CUSTOM` setup

Proceed at your own risk.

## 👋🏽 future me, run these commands

_after getting [`minidev`](https://github.com/jakxz/minidev) working_:

1. install https://ohmyz.sh
1. install https://brew.sh

```zsh
dev config set default.account jakxz
dev clone .zsh-custom
git submodule init
git submodule update
brew bundle install
cd ~
mv .zshrc .zshrc-backup
ln -s ~/src/github.com/jakxz/.zsh-custom/.zshrc .
ln -s ~/src/github.com/jakxz/.zsh-custom/.p10k.zsh .
gh auth login
```
