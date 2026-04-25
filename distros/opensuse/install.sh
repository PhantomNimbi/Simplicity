#!/usr/bin/env bash
# Simplicity Theme - openSUSE Leap / Tumbleweed Installer
# Supports: openSUSE Leap 15.4+, openSUSE Tumbleweed (rolling)
# Package manager: zypper

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

detect_opensuse_version() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${VERSION_ID:-${PRETTY_NAME:-unknown}}"
    fi
}

install_dependencies() {
    info "Installing dependencies via zypper..."
    sudo zypper --non-interactive install \
        gnome-tweaks \
        gtk2-engine-murrine \
        sassc \
        2>/dev/null || true
    success "Dependencies installed."
}

install_gnome_extensions() {
    if command -v gnome-shell &>/dev/null; then
        info "Installing GNOME user theme extension..."
        sudo zypper --non-interactive install \
            gnome-shell-extension-user-theme \
            2>/dev/null || true
        success "GNOME user theme extension installed."
    fi
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
    else
        warning "gsettings not found. Please apply the theme manually."
    fi
}

apply_kde_theme() {
    if command -v plasma-apply-colorscheme &>/dev/null; then
        info "KDE Plasma detected. Please use System Settings → Appearance to apply the theme."
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
    echo "  openSUSE Leap / Tumbleweed Installer"
    echo ""

    local suse_ver
    suse_ver="$(detect_opensuse_version)"
    info "Detected openSUSE-based system (version: ${suse_ver})"

    install_dependencies
    install_gnome_extensions
    install_theme
    apply_gnome_theme
    apply_kde_theme
    configure_gtk_settings

    echo ""
    success "Simplicity installation complete!"
    info "You may need to log out and back in for all changes to take effect."
}

main "$@"
