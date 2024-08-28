#!/bin/zsh

ZSHRC="$HOME/.zshrc"

# Configure macOS Settings
sudo systemsetup -setrestartpowerfailure on

# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set OhMyZSH theme
cp ./themes/* ~/.oh-my-zsh/themes
sed -i.bak "s/^ZSH_THEME=.*/ZSH_THEME=\"tangerine\"" "$ZSHRC"

# Install Homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew Dependencies
brew bundle install
rm ./Brewfile.lock.json

# Install transmission-openvpn
mkdir -p ~/.transmission-openvpn/vpn-config
cp ./config/vpn/* ~/.transmission-openvpn/vpn-config/*
docker-compose up ./config/transmission-openvpn/docker-compose.yml

# Install Coolify
sh -c "$(curl -fsSL https://cdn.coollabs.io/coolify/install.sh)"

# Start the VS Code Remote Tunnel
code tunnel service install

# Set .zshrc aliases
echo "alias rc=\"code ~/.zshrc\"" >> "$ZSHRC"

# Add other scripts to .zshrc
mkdir ~/.scripts
cp ./scripts ~/.scripts
echo "source ~/.scripts/media-commands.sh" >> "$ZSHRC"
