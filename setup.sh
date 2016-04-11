#!/bin/bash

ln -s ~/dotfiles/omzshrc ~/.omzshrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/rvmrc ~/.rvmrc
ln -s ~/dotfiles/gemrc ~/.gemrc
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
# Run this command to add the global gitignore
# git config --global core.excludesfile ~/.gitignore_global
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
# Run this command to make start executable:
# chmod +x /usr/local/bin/start
ln -s ~/dotfiles/start.rb /usr/local/bin/start
