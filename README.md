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
git clone --recurse-submodules https://github.com/JaKXz/.zsh-custom.git
cd .zsh-custom
brew install --cask gpg-suite && brew bundle install
```

```
cd ~
mv .zshrc .zshrc-backup
stow -v git -t ~
stow -v shell -t ~
stow -v mpv -t ~
```
