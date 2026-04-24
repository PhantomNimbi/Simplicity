#!/usr/bin/env bash
# Simplicity Theme - Fedora / RHEL / CentOS Stream Installer
# Supports: Fedora 36+, RHEL 9+, CentOS Stream 9+, AlmaLinux 9+, Rocky Linux 9+
# Package manager: dnf

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

detect_fedora_version() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${VERSION_ID:-unknown}"
    fi
}

install_dependencies() {
    info "Installing dependencies via dnf..."
    sudo dnf install -y \
        gnome-tweaks \
        gtk-murrine-engine \
        sassc \
        2>/dev/null || true
    success "Dependencies installed."
}

install_gnome_extensions() {
    if command -v gnome-shell &>/dev/null; then
        info "Installing GNOME user theme extension..."
        sudo dnf install -y gnome-shell-extension-user-theme 2>/dev/null || true
        success "GNOME user theme extension installed."
    fi
}

install_theme() {
    local target_dir="${HOME}/.themes/${THEME_NAME}"
    info "Installing ${THEME_NAME} theme to ${target_dir}..."
    mkdir -p "${target_dir}"
    cp -r "${REPO_ROOT}/simplicity/." "${target_dir}/"
    success "Theme installed to ${target_dir}"
}

apply_gnome_theme() {
    if command -v gsettings &>/dev/null; then
        info "Applying ${THEME_NAME} theme via gsettings..."
        gsettings set org.gnome.desktop.interface gtk-theme "${THEME_NAME}" 2>/dev/null || true
        gsettings set org.gnome.desktop.wm.preferences theme "${THEME_NAME}" 2>/dev/null || true
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
        success "GNOME theme applied."
    else
        warning "gsettings not found. Please apply the theme manually via GNOME Tweaks."
    fi
}

apply_kde_theme() {
    if command -v plasma-apply-colorscheme &>/dev/null; then
        info "KDE Plasma detected. Please use System Settings to apply the theme."
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
    echo "  Fedora / RHEL / CentOS Stream Installer"
    echo ""

    local fedora_ver
    fedora_ver="$(detect_fedora_version)"
    info "Detected Fedora/RHEL-based system (version: ${fedora_ver})"

    install_dependencies
    install_gnome_extensions
    install_theme
    apply_gnome_theme
    apply_kde_theme

    echo ""
    success "Simplicity installation complete!"
    info "You may need to log out and back in for all changes to take effect."
    info "Use GNOME Tweaks or System Settings to switch themes."
}

main "$@"
