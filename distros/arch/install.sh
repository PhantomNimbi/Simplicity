#!/usr/bin/env bash
# Simplicity Theme - Arch Linux / EndeavourOS / Garuda Installer
# Supports: Arch Linux (rolling), EndeavourOS, Garuda Linux, ArcoLinux
# Package manager: pacman / yay / paru

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
THEME_NAME="Simplicity"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
success() { echo -e "${GREEN}[OK]${NC}    $*"; }
warning() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }
die()     { error "$*"; exit 1; }

# Detect AUR helper
detect_aur_helper() {
    if command -v yay &>/dev/null; then
        echo "yay"
    elif command -v paru &>/dev/null; then
        echo "paru"
    else
        echo ""
    fi
}

install_dependencies() {
    local aur_helper
    aur_helper="$(detect_aur_helper)"

    info "Installing dependencies via pacman..."
    sudo pacman -S --needed --noconfirm \
        gnome-tweaks \
        gtk-engine-murrine \
        gtk-engines \
        sassc \
        2>/dev/null || true

    if [[ -n "${aur_helper}" ]]; then
        info "AUR helper '${aur_helper}' found. Installing AUR packages..."
        "${aur_helper}" -S --needed --noconfirm \
            gnome-shell-extension-user-theme \
            2>/dev/null || true
    else
        warning "No AUR helper found. Skipping AUR packages."
        info "To install an AUR helper, see: https://wiki.archlinux.org/title/AUR_helpers"
    fi

    success "Dependencies installed."
}

install_theme() {
    local target_dir="${HOME}/.themes/${THEME_NAME}"
    info "Installing ${THEME_NAME} theme to ${target_dir}..."
    mkdir -p "${target_dir}"
    cp -r "${REPO_ROOT}/simplicity-dualtone/." "${target_dir}/"
    success "Theme installed to ${target_dir}"
}

apply_gnome_theme() {
    if command -v gsettings &>/dev/null; then
        info "Applying ${THEME_NAME} theme via gsettings..."
        gsettings set org.gnome.desktop.interface gtk-theme "${THEME_NAME}" 2>/dev/null || true
        gsettings set org.gnome.desktop.wm.preferences theme "${THEME_NAME}" 2>/dev/null || true
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' 2>/dev/null || true
        success "GNOME theme applied."
    fi
}

apply_kde_theme() {
    if command -v plasma-apply-colorscheme &>/dev/null; then
        info "KDE Plasma detected. Please use System Settings to apply the theme."
    fi
}

apply_xfce_theme() {
    if command -v xfconf-query &>/dev/null; then
        info "Applying ${THEME_NAME} theme via xfconf (XFCE)..."
        xfconf-query -c xsettings -p /Net/ThemeName -s "${THEME_NAME}" 2>/dev/null || true
        xfconf-query -c xfwm4 -p /general/theme -s "${THEME_NAME}" 2>/dev/null || true
        success "XFCE theme applied."
    fi
}

# GTK settings file for environments without gsettings
configure_gtk_settings() {
    local gtk3_settings="${HOME}/.config/gtk-3.0/settings.ini"
    info "Configuring GTK settings file..."
    mkdir -p "${HOME}/.config/gtk-3.0"
    if [[ ! -f "${gtk3_settings}" ]]; then
        cp "${REPO_ROOT}/simplicity-dualtone/gtk-3.0/settings.ini" "${gtk3_settings}"
        success "GTK 3 settings configured."
    else
        warning "GTK 3 settings file already exists. Skipping."
    fi
}

main() {
    echo ""
    echo "  ██████╗ ███████╗███████╗██╗  ██╗████████╗██╗  ██╗███████╗███╗   ███╗"
    echo "  ██╔══██╗██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██║  ██║██╔════╝████╗ ████║"
    echo "  ██║  ██║█████╗  ███████╗█████╔╝    ██║   ███████║█████╗  ██╔████╔██║"
    echo "  ██║  ██║██╔══╝  ╚════██║██╔═██╗    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║"
    echo "  ██████╔╝███████╗███████║██║  ██╗   ██║   ██║  ██║███████╗██║ ╚═╝ ██║"
    echo "  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝"
    echo "  Arch Linux / EndeavourOS / Garuda Linux Installer"
    echo ""

    info "Detected Arch-based system"

    install_dependencies
    install_theme
    apply_gnome_theme
    apply_kde_theme
    apply_xfce_theme
    configure_gtk_settings

    echo ""
    success "Simplicity installation complete!"
    info "You may need to log out and back in for all changes to take effect."
    info "Arch Wiki: https://wiki.archlinux.org/title/GTK#Themes"
}

main "$@"
