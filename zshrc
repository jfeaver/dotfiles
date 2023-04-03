via() {
  ag -l "$1" | xargs -o vi
}

### OH-MY-ZSHRC
# Path to your oh-my-zsh installation.

if [ -e ~/.omzshrc ]; then
  source ~/.omzshrc
fi

### Consider Removing ###
### Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# ### Powerline
# # Make sure powerline is found
# if [ -d "$HOME/Library/Python/2.7/bin" ]; then
#   export PATH="$PATH:$HOME/Library/Python/2.7/bin"
# fi
#
# ### Node (alternate version at work being used)
# export PATH="/usr/local/opt/node@16/bin:$PATH"
#
# ### NPM
# # Add npm packages to the path
# if [ -d /usr/local/share/npm/bin ]; then
#   export PATH=$PATH:/usr/local/share/npm/bin
# fi
#
# ### RVM
# if [ -d ~/.rvm/bin ]; then
#   export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#
#   [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# fi
#
# ### chruby
# if [ -f /usr/local/share/chruby/chruby.sh ]; then
#   source /usr/local/share/chruby/chruby.sh
#   if [ -f /usr/local/share/chruby/auto.sh ]; then
#     source /usr/local/share/chruby/auto.sh
#   fi
# fi
#
#
# ### jenv
# if which jenv >/dev/null; then
#   export PATH="$HOME/.jenv/bin:$PATH"
#   eval "$(jenv init -)"
#   export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
#   alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'
# fi
#
# ### Go
# export PATH=$PATH:$HOME/go/bin
#
# ### Brew-installed Ruby
# if [ -d "/usr/local/opt/ruby/bin" ]; then
#   export PATH="/usr/local/opt/ruby/bin:$PATH"
# fi
#
# ### PROMPT
# autoload -U colors && colors
# function parse_git_branch {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "[${ref#refs/heads/}] "
# }
# local branch='$(parse_git_branch)'
#
# PS1="%{$fg[green]%}${branch}%{$reset_color%}`whoami`:%{$fg[blue]%}%~%{$reset_color%}$ "
# setopt promptsubst
#
# ### NVM
# # This seems to take a looooong time. Maybe hook it up to a function and run as needed?
# export NVM_DIR="$HOME/.nvm"
# # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# ### xcape (linux-only)
# # Use caps lock as a ctrl key and escape if tapped by itself
# # Use ctrl keys as escaped if tapped by themselves
# if [ -x /usr/bin/xcape ]; then
#   setxkbmap -option 'caps:ctrl_modifier'
#   xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
# fi
#
# ### Yarn
# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


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
eval "$(direnv hook zsh)"

### asdf
if [ -e /opt/homebrew/opt/asdf/libexec/asdf.sh ]; then
  source /opt/homebrew/opt/asdf/libexec/asdf.sh
fi
