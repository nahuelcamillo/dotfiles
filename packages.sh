#!/bin/bash

# Lista de paquetes en repositorios oficiales
PACMAN_PACKAGES=(
    alacritty
    atool
	arc-gtk-theme
    base-devel
    bat
    bpytop
	bridge-utils
    copyq
    curl
    dnsmasq
    docker
    docker-compose
	dunst
	expect
    feh
    filelight
    firefox
    firefox-developer-edition
    flameshot
	fprintd
    freerdp
	fwupd
    fzf
    galculator
    git
	git-delta
    htop
    i3blocks
    i3lock
    i3status
	iotops
    jq
    kate
    lazygit
    libguestfs
    libreoffice-fresh
    libvirt
    lsd
    neovim
    nerd-fonts-source-code-pro
    net-tools
    network-manager-applet
    networkmanager
    networkmanager-openvpn
    nitrogen
    obs-studio
    obsidian
    okular
    openbsd-netcat
    openfortivpn
    openresolv
    openssh
    pavucontrol
    peek
    pipewire-audio
    pipewire-pulse
    postgresql
    putty
	qt5ct
    ranger
    remmina
    rofi
    rofi-calc
    seahorse
	slack-desktop
    spotify
    starship
    steam
    sxhkd
    teams
    telegram-desktop
    thefuck
    timeshift
    tmux
    tree
    ueberzug
    unzip
    variety
    vde2
    virt-manager
    virt-viewer
    visual-studio-code-bin
    vlc
    whatsapp-nativefier
    wmctrl
    xdotool
    xf86-input-libinput
    yarn
    yay
    yq
    zoom
    zsh
    noto-fonts-emoji
)

# Lista de paquetes en AUR
AUR_PACKAGES=(
    1password
    1password-cli
    antidote
    cursor
    emojify
    forgit
    git-secret
    i3
    jetbrains-toolbox
    lazydocker
	libfprint-2-tod1-synatudor-git
    libinput-gestures
    mongodb-bin
    mongodb-compass
    mongodb-tools
    mongosh-bin
    nodejs-gitmoji-cli
    notion-app
    postman-bin
    qemu
    ruby-fusuma
    x11-emoji-picker
    zgen
    zsh-defer
    ttf-firacode-nerd
    ttf-font-awesome
    ttf-material-icons
)

FAILED_PACMAN=()
FAILED_AUR=()

install_yay() {
  if ! command -v yay &> /dev/null; then
    echo "📦 Instalando yay..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
  else
    echo "✅ yay ya está instalado."
  fi
}

install_pacman_packages() {
  echo "🔧 Instalando paquetes desde los repos oficiales..."
  for pkg in "${PACMAN_PACKAGES[@]}"; do
    echo "👉 Instalando: $pkg"
    if ! sudo pacman -S --needed --noconfirm "$pkg"; then
      FAILED_PACMAN+=("$pkg")
    fi
  done
}

install_aur_packages() {
  echo "🔧 Instalando paquetes desde AUR..."
  for pkg in "${AUR_PACKAGES[@]}"; do
    echo "👉 Instalando: $pkg"
    if ! yay -S --needed --noconfirm "$pkg"; then
      FAILED_AUR+=("$pkg")
    fi
  done
}

# ─────────────── Ejecución ───────────────

echo "🚀 Iniciando instalación de paquetes..."

install_yay
install_pacman_packages
install_aur_packages

# ─────────────── Reporte final ───────────────

echo ""
echo "🎯 Instalación finalizada."

if [ ${#FAILED_PACMAN[@]} -eq 0 ] && [ ${#FAILED_AUR[@]} -eq 0 ]; then
  echo "✅ Todos los paquetes fueron instalados correctamente."
else
  echo "⚠️ Algunos paquetes fallaron al instalarse:"
  if [ ${#FAILED_PACMAN[@]} -gt 0 ]; then
    echo "🔴 Fallaron en pacman:"
    printf '  - %s\n' "${FAILED_PACMAN[@]}"
  fi
  if [ ${#FAILED_AUR[@]} -gt 0 ]; then
    echo "🟠 Fallaron en AUR:"
    printf '  - %s\n' "${FAILED_AUR[@]}"
  fi
fi
