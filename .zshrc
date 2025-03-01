# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"
OP_BIOMETRIC_UNLOCK_ENABLED=true

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CUSTOM=$HOME/src/jakxz/.zsh-custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  node
  git
  brew
  yarn
  resty
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration
export GPG_TTY=$(tty)
export EDITOR=vim
export MANPAGER="less -R --use-color -Dd+r -Du+b"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f /opt/dev/dev.sh ]; then
  source /opt/dev/dev.sh
elif [ -f ~/src/jakxz/minidev/dev.sh ]; then
  source ~/src/jakxz/minidev/dev.sh
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bit bit

[[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)
[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/jasonkurian/.bun/_bun" ] && source "/Users/jasonkurian/.bun/_bun"
