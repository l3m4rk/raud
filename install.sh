#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
    printf '\n\033[1;34m==>\033[0m %s\n' "$1"
}

fail() {
    printf '\n\033[1;31mERROR:\033[0m %s\n' "$1" >&2
    exit 1
}

if [[ $EUID -eq 0 ]]; then
    fail "This script must not be run as root."
fi

if [[ ! -f /etc/arch-release ]]; then
    fail "raud v0.1 currently supports Arch Linux only."
fi

command -v sudo >/dev/null || fail "sudo is required."
command -v pacman >/dev/null || fail "pacman is required."

sudo -v

install_packages() {
    local file="$1"

    mapfile -t packages < <(
        grep -vE '^[[:space:]]*(#|$)' "$file"
    )

    if [[ ${#packages[@]} -eq 0 ]]; then
        return
    fi

    sudo pacman \
        -S \
        --needed \
        --noconfirm \
        "${packages[@]}"
}

log "Updating Arch Linux"
sudo pacman -Syu --noconfirm

log "Installing base packages"
install_packages "${ROOT}/packages/base.txt"

log "Installing desktop packages"
install_packages "${ROOT}/packages/desktop.txt"

log "Installing development packages"
install_packages "${ROOT}/packages/dev.txt"

log "Enabling system services"

sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service
sudo systemctl enable docker.service

log "Adding $USER to docker group"
sudo usermod -aG docker "$USER"

log "Installing configuration"

mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/waybar"
mkdir -p "$HOME/.config/ghostty"

cp -r "${ROOT}/config/hypr/." "$HOME/.config/hypr/"
cp -r "${ROOT}/config/waybar/." "$HOME/.config/waybar/"
cp -r "${ROOT}/config/ghostty/." "$HOME/.config/ghostty/"

log "Installing raud CLI"

mkdir -p "$HOME/.local/bin"
install -m 755 "${ROOT}/bin/raud" "$HOME/.local/bin/raud"

log "Installation complete"

printf '\n'
printf 'Reboot the system and run:\n'
printf '    start-hyprland\n\n'
