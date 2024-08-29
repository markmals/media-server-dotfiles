#!/bin/zsh

ZSHRC="$HOME/.zshrc"

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Configure macOS Settings
    sudo systemsetup -setrestartpowerfailure on

    # Install OhMyZSH
    (sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")

    # Set OhMyZSH theme
    sudo cp ./themes/* ~/.oh-my-zsh/themes
    # This didn't work; threw some error
    # sed -i.bak "s/^ZSH_THEME=.*/ZSH_THEME=\"tangerine\"" "$ZSHRC"
fi


# Install Homebrew
CI=1
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew Dependencies
brew bundle install

# Install transmission-openvpn
mkdir -p ~/.transmission-openvpn/vpn-config
sudo cp ./config/vpn/* ~/.transmission-openvpn/vpn-config
cd ./config/transmission-openvpn
sudo docker-compose up

# Install Coolify
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Coolify's install script only works on Linux
    sh -c "$(curl -fsSL https://cdn.coollabs.io/coolify/install.sh)"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sudo mkdir ~/Library/Application\ Support/coolify
    cd ~/Library/Application\ Support/coolify
    
    sudo curl -fsSL https://raw.githubusercontent.com/coollabsio/coolify/main/docker-compose.windows.yml -o ./docker-compose.yml
    sudo curl -fsSL https://cdn.coollabs.io/coolify/.env.production -o ./.env
    
    sudo sed -i "" "s|APP_ID=.*|APP_ID=$(openssl rand -hex 16)|g" ./.env
    sudo sed -i "" "s|APP_KEY=.*|APP_KEY=base64:$(openssl rand -base64 32)|g" ./.env
    sudo sed -i "" "s|DB_PASSWORD=.*|DB_PASSWORD=$(openssl rand -base64 32)|g" ./.env
    sudo sed -i "" "s|REDIS_PASSWORD=.*|REDIS_PASSWORD=$(openssl rand -base64 32)|g" ./.env
    sudo sed -i "" "s|PUSHER_APP_ID=.*|PUSHER_APP_ID=$(openssl rand -hex 32)|g" ./.env
    sudo sed -i "" "s|PUSHER_APP_KEY=.*|PUSHER_APP_KEY=$(openssl rand -hex 32)|g" ./.env
    sudo sed -i "" "s|PUSHER_APP_SECRET=.*|PUSHER_APP_SECRET=$(openssl rand -hex 32)|g" ./.env
    
    sudo chmod -R 755 ~/Library/Application\ Support/coolify
    sudo chown -R $(whoami) ~/Library/Application\ Support/coolify
    
    docker compose up -d
fi


# Start the VS Code Remote Tunnel
# This requires user input
# code tunnel service install

# Set .zshrc aliases
echo "alias rc=\"code ~/.zshrc\"" >> "$ZSHRC"

# Add other scripts to .zshrc
mkdir ~/.scripts
sudo cp ./scripts/* ~/.scripts
echo "source ~/.scripts/media-commands.sh" >> "$ZSHRC"
