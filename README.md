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
brew install --cask gpg-suite@nightly && brew bundle install
for folder in $(find . -type d -maxdepth 1 -not -name ".git" -not -name "themes" -not -name "plugins" -not -name "." | cut -c3-); do
  if [ "$folder" = clankers ]; then
    mkdir -p ~/.agents/skills ~/.claude/hooks ~/.claude/skills \
      ~/.codex/hooks ~/.codex/rules ~/.codex/skills
  fi
  stow -v "$folder" -t ~
done
```

### Extra env

- [macOS](https://0xmachos.com/2021-05-13-zsh-path-macos/)
  ```
  touch ~/.zshenv
  ```

### `clankers` configuration

```sh
mkdir -p ~/.agents/skills ~/.claude/hooks ~/.claude/skills \
  ~/.codex/hooks ~/.codex/rules ~/.codex/skills
stow --simulate --verbose --target="$HOME" clankers
stow --verbose --target="$HOME" clankers
```
