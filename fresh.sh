#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    echo "++++++++++++++++++++++++++++++++++++++"
    echo "==> Brew not found. Will be installed now..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "++++++++++++++++++++++++++++++++++++++"
    echo "==> Brew is already installed!"
fi

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
    echo "++++++++++++++++++++++++++++++++++++++"
    echo "==> OMZ not found. Will be installed now..."

    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
    echo "++++++++++++++++++++++++++++++++++++++"
    echo "==> OMZ is already installed!"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
echo "++++++++++++++++++++++++++++++++++++++"
echo "Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles"
echo "++++++++++++++++++++++++++++++++++++++"
rm -rf $HOME/.zshrc
ln -v -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Update Homebrew recipes"
brew update

# Install all our dependencies with bundle (See Brewfile)
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Install all our dependencies with bundle (See Brewfile)"
brew tap homebrew/bundle
brew bundle -v --file ./Brewfile
brew autoupdate delete
brew autoupdate --start 43200 --upgrade --cleanup

# Set default MySQL root password and auth type
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Set default MySQL root password and auth type"
mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Create a Sites directory
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Create a Sites directory"
mkdir $HOME/Sites
mkdir $HOME/Sites/Navigaite

# Clone Github repositories
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Clone Github repositories"
./clone.sh

# Symlink the Mackup config file to the home directory
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Symlink the Mackup config file to the home directory"
rm -rf $HOME/.mackup.cfg
ln -v -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Symlink the gitconfig config file to the home directory
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Symlink the gitconfig config file to the home directory"
rm -rf $HOME/.gitconfig
ln -v -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

# Symlink the yabai config file to the home directory
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Symlink the yabai config file to the home directory"
rm -rf $HOME/.yabairc
ln -v -s $HOME/.dotfiles/.yabairc $HOME/.yabairc
chmod +x $HOME/.yabairc

# Symlink the Powerlevel10k config file to the home directory
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Symlink the Powerlevel10k config file to the home directory"
rm -rf $HOME/.p10k.zsh
ln -v -s $HOME/.dotfiles/.p10k.zsh $HOME/.p10k.zsh

# Set macOS preferences - we will run this last because this will reload the shell
echo "++++++++++++++++++++++++++++++++++++++"
echo "==> Set macOS preferences - we will run this last because this will reload the shell"
# source ./.macos
