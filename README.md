# my terminal + `$ZSH_CUSTOM` setup

> Proceed at your own risk.

## 👋🏽 future me, run these commands

1. install https://ohmyz.sh
1. install https://brew.sh

```
brew install gh
gh auth login
```

```
mkdir -pv ~/src/jakxz && cd $_
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
ln -s ~/src/jakxz/.zsh-custom/.zshrc .
ln -s ~/src/jakxz/.zsh-custom/.p10k.zsh .
```

```
dev config set default.account jakxz
dev config set default.github_root ~/src
```
