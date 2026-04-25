#!/usr/bin/env bash
# install.sh — Simplicity Theme Suite Main Installer
# Automatically detects your Linux distribution and installs the Simplicity theme
#
# Usage: ./install.sh [--system] [--no-apply] [--help]
#
# Options:
#   --system      Install to /usr/share/themes (requires root) instead of ~/.themes
#   --no-apply    Install files only; do not apply the theme to the current session
#   --dark        Also install the Simplicity-Dark (full dark) variant
#   --light       Also install the Simplicity-Light (full light) variant
#   --dracula     Also install the Simplicity-Dracula variant
#   --help        Show this help message

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="Simplicity"
THEME_DARK_NAME="Simplicity-Dark"
THEME_LIGHT_NAME="Simplicity-Light"
THEME_DRACULA_NAME="Simplicity-Dracula"
SYSTEM_INSTALL=false
NO_APPLY=false
INSTALL_DARK=false
INSTALL_LIGHT=false
INSTALL_DRACULA=false

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
success() { echo -e "${GREEN}[OK]${NC}    $*"; }
warning() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }
die()     { error "$*"; exit 1; }
header()  { echo -e "${BOLD}$*${NC}"; }

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --system)
            SYSTEM_INSTALL=true
            ;;
        --no-apply)
            NO_APPLY=true
            ;;
        --light)
            INSTALL_LIGHT=true
            ;;
        --dark)
            INSTALL_DARK=true
            ;;
        --dracula)
            INSTALL_DRACULA=true
            ;;
        --help|-h)
            echo "Simplicity Theme Suite Installer"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --system      Install to /usr/share/themes (requires root)"
            echo "  --no-apply    Install files only; do not apply the theme"
            echo "  --light       Also install the Simplicity-Light (full light) variant"
            echo "  --dark        Also install the Simplicity-Dark (full dark) variant"
            echo "  --dracula     Also install the Simplicity-Dracula variant"
            echo "  --help, -h    Show this help message"
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            echo "Run '$0 --help' for usage."
            exit 1
            ;;
    esac
    shift
done

print_banner() {
    echo ""
    echo -e "${BLUE}"
    echo "  ██████╗ ███████╗███████╗██╗  ██╗████████╗██╗  ██╗███████╗███╗   ███╗"
    echo "  ██╔══██╗██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██║  ██║██╔════╝████╗ ████║"
    echo "  ██║  ██║█████╗  ███████╗█████╔╝    ██║   ███████║█████╗  ██╔████╔██║"
    echo "  ██║  ██║██╔══╝  ╚════██║██╔═██╗    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║"
    echo "  ██████╔╝███████╗███████║██║  ██╗   ██║   ██║  ██║███████╗██║ ╚═╝ ██║"
    echo "  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝"
    echo -e "${NC}"
    echo "  A clean and modern theme suite for Linux desktop environments"
    echo "  Supports: GNOME · KDE · XFCE · MATE · Cinnamon · Openbox · i3 · Sway"
    echo "  Distros:  Ubuntu · Debian · Fedora · Arch · openSUSE · Manjaro · and more"
    echo ""
}

# Source the distro detection script
# shellcheck source=scripts/detect-distro.sh
source "${SCRIPT_DIR}/scripts/detect-distro.sh"

install_theme_files() {
    local target_dir

    if "${SYSTEM_INSTALL}"; then
        target_dir="/usr/share/themes/${THEME_NAME}"
        info "Installing to system directory: ${target_dir}"
        if [[ "${EUID}" -ne 0 ]]; then
            die "System installation requires root privileges. Run with sudo or use --system after sudo."
        fi
    else
        target_dir="${HOME}/.themes/${THEME_NAME}"
        info "Installing to user directory: ${target_dir}"
    fi

    mkdir -p "${target_dir}"
    cp -r "${SCRIPT_DIR}/simplicity-dualtone/." "${target_dir}/"
    success "Theme files installed to: ${target_dir}"

    if "${INSTALL_LIGHT}"; then
        local light_target_dir
        if "${SYSTEM_INSTALL}"; then
            light_target_dir="/usr/share/themes/${THEME_LIGHT_NAME}"
        else
            light_target_dir="${HOME}/.themes/${THEME_LIGHT_NAME}"
        fi
        info "Installing light variant to: ${light_target_dir}"
        mkdir -p "${light_target_dir}"
        cp -r "${SCRIPT_DIR}/simplicity-light/." "${light_target_dir}/"
        success "Light variant installed to: ${light_target_dir}"
    fi

    if "${INSTALL_DARK}"; then
        local dark_target_dir
        if "${SYSTEM_INSTALL}"; then
            dark_target_dir="/usr/share/themes/${THEME_DARK_NAME}"
        else
            dark_target_dir="${HOME}/.themes/${THEME_DARK_NAME}"
        fi
        info "Installing dark variant to: ${dark_target_dir}"
        mkdir -p "${dark_target_dir}"
        cp -r "${SCRIPT_DIR}/simplicity-dark/." "${dark_target_dir}/"
        success "Dark variant installed to: ${dark_target_dir}"
    fi

    if "${INSTALL_DRACULA}"; then
        local dracula_target_dir
        if "${SYSTEM_INSTALL}"; then
            dracula_target_dir="/usr/share/themes/${THEME_DRACULA_NAME}"
        else
            dracula_target_dir="${HOME}/.themes/${THEME_DRACULA_NAME}"
        fi
        info "Installing Dracula variant to: ${dracula_target_dir}"
        mkdir -p "${dracula_target_dir}"
        cp -r "${SCRIPT_DIR}/simplicity-dracula/." "${dracula_target_dir}/"
        success "Dracula variant installed to: ${dracula_target_dir}"
    fi
}

install_distro_specific() {
    detect_distro
    info "Detected: ${DISTRO_ID} (family: ${DISTRO_FAMILY}, package manager: ${PKG_MANAGER})"

    local distro_installer=""

    case "${DISTRO_ID}" in
        ubuntu|linuxmint|pop|elementary|zorin|neon|kubuntu|xubuntu|lubuntu)
            distro_installer="${SCRIPT_DIR}/distros/ubuntu/install.sh"
            ;;
        debian|raspbian|mx|antix|kali|parrot)
            distro_installer="${SCRIPT_DIR}/distros/debian/install.sh"
            ;;
        fedora|rhel|centos|almalinux|rocky|ol|nobara)
            distro_installer="${SCRIPT_DIR}/distros/fedora/install.sh"
            ;;
        arch|endeavouros|garuda|arcolinux|artix)
            distro_installer="${SCRIPT_DIR}/distros/arch/install.sh"
            ;;
        manjaro)
            distro_installer="${SCRIPT_DIR}/distros/manjaro/install.sh"
            ;;
        opensuse*|sles|sled)
            distro_installer="${SCRIPT_DIR}/distros/opensuse/install.sh"
            ;;
        *)
            warning "Distribution '${DISTRO_ID}' not specifically supported."
            info "Attempting generic installation..."
            ;;
    esac

    if [[ -n "${distro_installer}" ]] && [[ -f "${distro_installer}" ]]; then
        info "Running distribution-specific installer..."
        bash "${distro_installer}"
    fi
}

apply_theme() {
    if "${NO_APPLY}"; then
        info "Skipping theme application (--no-apply specified)."
        return
    fi

    if [[ -f "${SCRIPT_DIR}/scripts/apply-theme.sh" ]]; then
        info "Applying theme to current desktop session..."
        bash "${SCRIPT_DIR}/scripts/apply-theme.sh"
    fi
}

main() {
    print_banner

    header "Step 1/3: Detecting your system..."
    detect_distro
    info "OS: ${DISTRO_ID} ${DISTRO_VERSION} (${DISTRO_FAMILY} family)"
    info "Package manager: ${PKG_MANAGER}"
    echo ""

    header "Step 2/3: Installing theme files..."
    install_theme_files
    echo ""

    header "Step 3/3: Installing dependencies and applying theme..."
    install_distro_specific
    apply_theme
    echo ""

    success "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    success "  Simplicity installation complete!"
    success "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    info "To uninstall, run: ./uninstall.sh"
    info "For help, see: README.md"
    echo ""
}

main "$@"
