#!/bin/bash

ln -s ~/dotfiles/omzshrc ~/.omzshrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/rvmrc ~/.rvmrc
ln -s ~/dotfiles/gemrc ~/.gemrc
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/sshc ~/.ssh/config
ln -s ~/dotfiles/agignore ~/.agignore

if ! [ -f ~/bin ]; then
  mkdir ~/bin
fi

ln -s ~/dotfiles/start.rb ~/bin/start
chmod +x ~/bin/start
