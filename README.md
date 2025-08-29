Dotfiles
========

A collection of my config files for ZSH, Oh-My-Zsh, Vim, Tmux, and Powerline.  This has
been inspired by [Dr. Bunsen's Text Triumvirate](http://www.drbunsen.org/the-text-triumvirate/).

Setup
=====

1. Clone this repository into your home directory: `git clone
git@github.com:jfeaver/dotfiles.git ~/dotfiles`

2. Install ZSH, Node

3. Install Vim (make sure you install the non-"Tiny version without GUI" such as vim-gtk3), Vundle

4. Install Oh-My-Zsh because it will create some config files and overwrite the symlinks
that we'll create in the next couple of steps (zshrc for me).

5. Move or remove existing config files (if they exist):
  - ~/.atom/config.cson
  - ~/.zshrc
  - ~/.omzshrc
  - ~/.vimrc
  - ~/.tmux.conf
  - ~/.rvmrc
  - ~/.gemrc
  - ~/.gitconfig
  - ~/.gitignore\_global
  - ~/.ssh/config
  - ~/.agignore

6. Run `./setup.sh` (Creates symbolic links from the home directory to the dotfiles directory)

7. Change the zshrc theme to your own in `~/dotfiles/omzshrc`

Software
========

First, install Homebrew using the instructions from their homepage.

Use brew to install: zsh, vim, git, tmux
Install Vundle: https://github.com/VundleVim/Vundle.vim#quick-start
and run the command to install Vundle plugins: :PluginInstall

tmux might need reattach-to-user-namespace which can be installed via Homebrew (it allows us
to copy/paste inside tmux sessions in OSX).

### Caps and R-ctrl key remapping

Mac: Change Keyboard Modifier Keys, install [Karabiner](https://pqrs.org/osx/karabiner/) and change left control settings (after granting Karabiner accessibility options in Security preferences)
Linux: [xcape](https://github.com/alols/xcape)(see zshrc config) and GNOME Tweaks (sudo apt install gnome-tweaks): Keyboard -> Additional Layout Options -> Caps Lock behavior -> Make Caps Lock an additional Ctrl

Open ~/.config/karabiner/karabiner.json and add/replace with these rules:
                rules: [
                    {
                        "manipulators": [
                            {
                                "description": "Change caps_lock to control.",
                                "from": {
                                    "key_code": "caps_lock",
                                    "modifiers": {
                                        "optional": [
                                            "any"
                                        ]
                                    }
                                },
                                "to": [
                                    {
                                        "key_code": "left_control"
                                    }
                                ],
                                "to_if_alone": [
                                    {
                                        "key_code": "escape"
                                    }
                                ],
                                "type": "basic"
                            }
                        ]
                    }
                ]
