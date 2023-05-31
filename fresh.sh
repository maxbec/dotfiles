#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  echo "++++++++++++++++++++++++++++++++++++++"
  echo "Brew not found. Will be installed now..."
  echo "++++++++++++++++++++++++++++++++++++++"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "++++++++++++++++++++++++++++++++++++++"
  echo "Brew is already installed!"
  echo "++++++++++++++++++++++++++++++++++++++"
fi

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  echo "++++++++++++++++++++++++++++++++++++++"
  echo "OMZ not found. Will be installed now..."
  echo "++++++++++++++++++++++++++++++++++++++"

  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
  echo "++++++++++++++++++++++++++++++++++++++"
  echo "OMZ is already installed!"
  echo "++++++++++++++++++++++++++++++++++++++"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
echo "++++++++++++++++++++++++++++++++++++++"
echo "Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles"
echo "++++++++++++++++++++++++++++++++++++++"
rm -rf $HOME/.zshrc
ln -s .zshrc $HOME/.zshrc

# Update Homebrew recipes
echo "++++++++++++++++++++++++++++++++++++++"
echo "Update Homebrew recipes"
echo "++++++++++++++++++++++++++++++++++++++"
brew update

# Install all our dependencies with bundle (See Brewfile)
echo "++++++++++++++++++++++++++++++++++++++"
echo "Install all our dependencies with bundle (See Brewfile)"
echo "++++++++++++++++++++++++++++++++++++++"
brew tap homebrew/bundle
brew bundle -v --file ./Brewfile

# Set default MySQL root password and auth type
echo "++++++++++++++++++++++++++++++++++++++"
echo "Set default MySQL root password and auth type"
echo "++++++++++++++++++++++++++++++++++++++"
mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Create a Sites directory
echo "++++++++++++++++++++++++++++++++++++++"
echo "Create a Sites directory"
echo "++++++++++++++++++++++++++++++++++++++"
mkdir $HOME/Sites

# Create sites subdirectories
echo "++++++++++++++++++++++++++++++++++++++"
echo "Create sites subdirectories"
echo "++++++++++++++++++++++++++++++++++++++"
mkdir $HOME/Sites/Navigaite

# Clone Github repositories
echo "++++++++++++++++++++++++++++++++++++++"
echo "Clone Github repositories"
echo "++++++++++++++++++++++++++++++++++++++"
./clone.sh

# Symlink the Mackup config file to the home directory
echo "++++++++++++++++++++++++++++++++++++++"
echo "Symlink the Mackup config file to the home directory"
echo "++++++++++++++++++++++++++++++++++++++"
ln -s .mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
echo "++++++++++++++++++++++++++++++++++++++"
echo "Set macOS preferences - we will run this last because this will reload the shell"
echo "++++++++++++++++++++++++++++++++++++++"
source ./.macos
