#!/bin/sh

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles..."

#install Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#Remove zshrc that is installed with oh-my-zsh because we symlink our own later
rm ~/.zshrc

source symlink.sh

# Check for Homebrew and install if we don't have it
  if test ! "$( command -v brew )"; then
      echo "Installing homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/sanderpeeters/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Change the default shell to zsh
zsh_path="$( command -v zsh )"
if ! grep "$zsh_path" /etc/shells; then
    echo "adding $zsh_path to /etc/shells"
    echo "$zsh_path" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$zsh_path" ]]; then
    chsh -s "$zsh_path"
    echo "default shell changed to $zsh_path"
fi

# Install global NPM packages
npm install --global nvm

# Create a Projects directory
mkdir $HOME/Documents/Projects
mkdir $HOME/Documents/Personal-projects

# Set .ssh permissions
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
chmod 644 ~/.ssh/config
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

# Set macOS preferences
# We will run this last because this will reload the shell
source osx.sh
