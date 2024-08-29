tap "homebrew/bundle"
tap "homebrew/services"
tap "markmals/media-server"

# Media Tools
brew "ffmpeg"
brew "yt-dlp"
brew "vimeo-dl"

# Network Tools
brew "cloudflared"
brew "httpd"

if OS.linux?
    brew "docker"
    brew "docker-compose"
end

if OS.mac?
    tap "buo/cask-upgrade"
    tap "artginzburg/tap"

    # Utilities
    brew "mas"
    brew "trash"
    brew "sudo-touchid", restart_service: true

    # GUI Apps
    cask "1password"
    cask "arc"
    cask "docker"
    cask "iina"
    cask "istat-menus"
    cask "orbstack"
    cask "plex-media-server"
    cask "visual-studio-code"
    mas "Meta", id: 558317092
    mas "Pastebot", id: 1179623856
    
    # Visual Studio Code Extensions
    vscode "antfu.file-nesting"
    vscode "bierner.markdown-preview-github-styles"
    vscode "esbenp.prettier-vscode"
    vscode "github.github-vscode-theme"
    vscode "miguelsolorio.fluent-icons"
    vscode "miguelsolorio.symbols"
    vscode "ms-vscode-remote.remote-containers"
    vscode "ms-vscode-remote.remote-ssh"
    vscode "ms-vscode-remote.remote-ssh-edit"
    vscode "ms-vscode.remote-explorer"
    vscode "redhat.vscode-xml"
end
