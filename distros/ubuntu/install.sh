#!/usr/bin/env bash
# Simplicity Theme - Ubuntu / Linux Mint / Pop!_OS Installer
# Supports: Ubuntu 20.04 – 26.04 LTS, Linux Mint 20+, Pop!_OS 20.04+
# Package manager: apt

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
THEME_NAME="Simplicity"

# Colors for output
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

# Detect Ubuntu version
detect_ubuntu_version() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${VERSION_ID:-unknown}"
    fi
}

# Install dependencies via apt
install_dependencies() {
    info "Installing dependencies..."
    sudo apt-get update -qq
    sudo apt-get install -y \
        gnome-tweaks \
        gtk2-engines-murrine \
        gtk2-engines-pixbuf \
        sassc \
        2>/dev/null || true
    success "Dependencies installed."
}

# Install GNOME Shell integration for Ubuntu
install_gnome_extensions() {
    if command -v gnome-shell &>/dev/null; then
        info "Installing GNOME user theme extension support..."
        sudo apt-get install -y gnome-shell-extension-user-theme 2>/dev/null || true
        success "GNOME Shell extension support installed."
    fi
}

# Copy theme files to user theme directory
install_theme() {
    local target_dir="${HOME}/.themes/${THEME_NAME}"
    info "Installing ${THEME_NAME} theme to ${target_dir}..."
    mkdir -p "${target_dir}"
    cp -r "${REPO_ROOT}/simplicity-dualtone/." "${target_dir}/"
    success "Theme installed to ${target_dir}"
}

# Install the Simplicity icon theme
install_icon_theme() {
    local icon_target_dir="${HOME}/.local/share/icons/Simplicity-Icons"
    info "Installing Simplicity-Icons icon theme to ${icon_target_dir}..."
    mkdir -p "${icon_target_dir}"
    cp -r "${REPO_ROOT}/simplicity-icons/." "${icon_target_dir}/"
    success "Icon theme installed to ${icon_target_dir}"
    if command -v gtk-update-icon-cache &>/dev/null; then
        gtk-update-icon-cache -f -t "${icon_target_dir}" 2>/dev/null || true
    fi
}

# Apply the theme using gsettings (GNOME)
apply_gnome_theme() {
    if command -v gsettings &>/dev/null; then
        info "Applying ${THEME_NAME} theme via gsettings..."
        gsettings set org.gnome.desktop.interface gtk-theme "${THEME_NAME}" 2>/dev/null || true
        gsettings set org.gnome.desktop.wm.preferences theme "${THEME_NAME}" 2>/dev/null || true
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light' 2>/dev/null || true
        success "GNOME theme applied."
    else
        warning "gsettings not found. Please apply the theme manually via GNOME Tweaks."
    fi
}

# Apply via xfconf (XFCE)
apply_xfce_theme() {
    if command -v xfconf-query &>/dev/null; then
        info "Applying ${THEME_NAME} theme via xfconf (XFCE)..."
        xfconf-query -c xsettings -p /Net/ThemeName -s "${THEME_NAME}" 2>/dev/null || true
        xfconf-query -c xfwm4 -p /general/theme -s "${THEME_NAME}" 2>/dev/null || true
        success "XFCE theme applied."
    fi
}

configure_gtk_settings() {
    local gtk3_settings="${HOME}/.config/gtk-3.0/settings.ini"
    info "Configuring GTK settings..."
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
    echo "  Ubuntu / Linux Mint / Pop!_OS Installer"
    echo ""

    local ubuntu_ver
    ubuntu_ver="$(detect_ubuntu_version)"
    info "Detected Ubuntu-based system (version: ${ubuntu_ver})"

    install_dependencies
    install_gnome_extensions
    install_theme
    install_icon_theme
    apply_gnome_theme
    apply_xfce_theme
    configure_gtk_settings

    echo ""
    success "Simplicity installation complete!"
    info "You may need to log out and back in for all changes to take effect."
    info "Use GNOME Tweaks or the Appearance settings to switch themes."
}

main "$@"
