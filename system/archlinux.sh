#!/bin/bash

################################
#   TESTED WITH ARCH LINUX     #
################################

export BIN=Applications

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Get information on the newest versions of packages and their dependencies.
pacman -Syu

# Create BIN directory if no exists
mkdir ~/$BIN

# Install useful binaries
pacman -S git --noconfirm
pacman -S tree --noconfirm

# Install more recent version of Vim
pacman -S vim --noconfirm

# Install zsh and oh-my-zsh
pacman -S zsh --noconfirm
chsh -s $(which zsh)
sh -c "$(curl -fsSL \
  https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Adding diff-so-fancy for git log
# See https://github.com/git/git/tree/master/contrib/diff-highlight
sudo ln -sf /usr/share/doc/git/contrib/diff-highlight/diff-highlight /bin/
sudo chmod +x /bin/diff-highlight
git clone https://github.com/so-fancy/diff-so-fancy $HOME/$BIN/diff-so-fancy
echo "\n*** Don't forget to add $HOME/$BIN/diff-highlight to the PATH"

# Clone this repo and change to its directory
git clone https://github.com/auroredea/dotfiles $HOME/.dotfiles
cd $HOME/.dotfiles || exit

# symlink it up!
./system/symlink_setup.sh

echo "\n*** Finished setting up your system! Logout and login again."
