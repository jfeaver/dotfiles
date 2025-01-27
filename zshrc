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

### direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

### asdf
# Loading via omzshrc plugin
# if [ -e /opt/homebrew/opt/asdf/libexec/asdf.sh ]; then
#   source /opt/homebrew/opt/asdf/libexec/asdf.sh
# fi
