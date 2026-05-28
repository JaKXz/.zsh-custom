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
for folder in $(find . -type d -maxdepth 1 -not -name ".git" -not -name "themes" -not -name "plugins" -not -name "." | cut -c3-); do
  stow -v $folder -t ~
done
```
