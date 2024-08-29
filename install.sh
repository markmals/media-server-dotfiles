#!/bin/zsh

ZSHRC="$HOME/.zshrc"

# Configure macOS Settings
sudo systemsetup -setrestartpowerfailure on

# Install OhMyZSH
(sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")

# Set OhMyZSH theme
sudo cp ./themes/* ~/.oh-my-zsh/themes
# This didn't work; threw some error
# sed -i.bak "s/^ZSH_THEME=.*/ZSH_THEME=\"tangerine\"" "$ZSHRC"

# Install Homebrew
CI=1
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew Dependencies
brew bundle install
# rm ./Brewfile.lock.json

# Install transmission-openvpn
mkdir -p ~/.transmission-openvpn/vpn-config
sudo cp ./config/vpn/* ~/.transmission-openvpn/vpn-config
cd ./config/transmission-openvpn
sudo docker-compose up

# Install Coolify
# Coolify's install script only works on Linux
# sh -c "$(curl -fsSL https://cdn.coollabs.io/coolify/install.sh)"

# Start the VS Code Remote Tunnel
# This requires user input
# code tunnel service install

# Set .zshrc aliases
echo "alias rc=\"code ~/.zshrc\"" >> "$ZSHRC"

# Add other scripts to .zshrc
mkdir ~/.scripts
sudo cp ./scripts/* ~/.scripts
echo "source ~/.scripts/media-commands.sh" >> "$ZSHRC"
