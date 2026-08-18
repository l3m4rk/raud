#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
    printf '\n\033[1;34m[raud]\033[0m %s\n' "$1"
}

die() {
    printf '\n\033[1;31m[raud ERROR]\033[0m %s\n' "$1" >&2
    exit 1
}

on_error() {
    local exit_code=$?
    printf '\n\033[1;31m[raud ERROR]\033[0m installation failed at line %s\n' \
            "${BASH_LINENO[0]}" >&2
    exit "$exit_code"
}

trap on_error ERR

if [[ $EUID -eq 0 ]]; then
    die "Run the raud installer as a regular user, not as root."
fi

if [[ ! -f /etc/arch-release ]]; then
    die "raud v0.1 currently supports Arch Linux only."
fi

[[ "$(uname -m)" == "x86_64" ]] \
    || die "raud v0.1 supports x86_64 only."

command -v sudo >/dev/null || die "sudo is required."
command -v pacman >/dev/null || die "pacman is required."

sudo -v

install_pattern() {
    local pattern="$1"
    local file="$ROOT/patterns/$pattern.txt"

    [[ -f "$file" ]] || die "Pattern does not exist: $pattern"

    mapfile -t packages < <(
        grep -vE '^[[:space:]]*(#|$)' "$file"
    )

    if [[ ${#packages[@]} -eq 0 ]]; then
        return
    fi

    log "Applying pattern: $pattern"

    sudo pacman \
        -S \
        --needed \
        --noconfirm \
        "${packages[@]}"
}

install_config_dir() {
    local source="$1"
    local destination="$2"

    mkdir -p "$destination"
    cp -a "$source/." "$destination/"
}

log "Synchronizing Arch Linux"
sudo pacman -Syu --noconfirm

install_pattern base
install_pattern desktop
install_pattern dev

log "Enabling system services"

sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service
sudo systemctl enable docker.service

log "Configuring interactive shell"

if [[ "$(getenv passwd "$USER" | cut -d: -f7)" != "/usr/bin/zsh" ]]; then
    sudo chsh -s /usr/bin/zsh "$USER"
fi

install -m 644 \
    "$ROOT/config/zsh/zshrc" \
    "$HOME/.zshrc"

log "Installing descktop configuration"

install_config_dir "$ROOT/config/hypr" "$HOME/.config/hypr"
install_config_dir "$ROOT/config/waybar" "$HOME/.config/waybar"
install_config_dir "$ROOT/config/ghostty" "$HOME/.config/ghostty"

log "Adding $USER to docker group"
sudo usermod -aG docker "$USER"

log "Installing raud CLI"

sudo install \
    -Dm 755 \
    "$ROOT/bin/raud" \
    /usr/local/bin/raud

log "raud installation complete"

printf '\nReboot the machine and start Hyprland.\n'
printf 'Then run:\n\n'
printf '    raud doctor\n\n'
