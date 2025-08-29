via() {
  ag -l "$1" | xargs -o vi
}

### OH-MY-ZSHRC
# Path to your oh-my-zsh installation.

if [ -e ~/.omzshrc ]; then
  source ~/.omzshrc
fi

### .local/bin
if [ -d ~/.local/bin ]; then
  export PATH=~/.local/bin:$PATH
fi

### Brew
if [[ $(uname -m) == 'arm64' ]]; then
  export PATH=/opt/homebrew/bin:$PATH
else
  export PATH=/usr/local/sbin:$PATH
fi

### CMake (Compiling Aseprite)
export PATH=$PATH:/Applications/CMake.app/Contents/bin

### ALIASES
if [ -f ~/dotfiles/aliases ]; then
  source ~/dotfiles/aliases
fi

### VIM-LIKE ZSH
export EDITOR="vim"
bindkey -v

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Auto change directory (don't need to type `cd`)
setopt AUTO_CD

### rbenv
if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init - zsh)"
fi

### nvm
if [ -f ~/.nvm/nvm.sh ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

### direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

### conda
conda() {
  # Remove this function so that we don't get here next time.
  unset -f conda
  # Evaluate the hook in the current shell so that its definitions become global.
  eval "$(/home/nathan/pkg/miniconda3/bin/conda shell.zsh hook)"
  # Now that the real 'conda' is defined, call it with any arguments.
  conda "$@"
}

### asdf
# Loading via omzshrc plugin
# if [ -e /opt/homebrew/opt/asdf/libexec/asdf.sh ]; then
#   source /opt/homebrew/opt/asdf/libexec/asdf.sh
# fi

# Maybe I need this for VS Code?
# . "$HOME/snap/code/198/.local/share/../bin/env"

### xcape
if command -v xcape &> /dev/null; then
  xcape -e 'Caps_Lock=Escape'
fi
