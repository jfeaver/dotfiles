#!/bin/bash

ln -s ~/dotfiles/atomrc.cson ~/.atom/config.cson
ln -s ~/dotfiles/omzshrc ~/.omzshrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/rvmrc ~/.rvmrc
ln -s ~/dotfiles/gemrc ~/.gemrc
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
# Run this command to make start executable:
# chmod +x /usr/local/bin/start
ln -s ~/dotfiles/start.rb /usr/local/bin/start
