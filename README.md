# my `$ZSH_CUSTOM` setup

Proceed at your own risk.

## 👋🏽 future me, run these commands

1. install https://ohmyz.sh
1. install https://brew.sh

```
mkdir -pv ~/src/github.com/jakxz && cd $_
git clone https://github.com/JaKXz/minidev.git
git clone https://github.com/JaKXz/.zsh-custom.git
cd .zsh-custom
git submodule init
git submodule update
brew install --cask gpg-suite && brew bundle install
```

```
cd ~
mv .zshrc .zshrc-backup
ln -s ~/src/github.com/jakxz/.zsh-custom/.zshrc .
ln -s ~/src/github.com/jakxz/.zsh-custom/.p10k.zsh .
gh auth login
```
