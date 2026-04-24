#!/usr/bin/env bash
# detect-distro.sh — Detect Linux distribution and return distro info
# Part of the Simplicity theme suite
#
# Usage: source ./scripts/detect-distro.sh
#        detect_distro  → sets DISTRO_ID, DISTRO_VERSION, DISTRO_FAMILY, PKG_MANAGER

set -euo pipefail

# Detect the Linux distribution
# Sets the following variables:
#   DISTRO_ID       - machine-readable distro ID (e.g. ubuntu, fedora, arch)
#   DISTRO_VERSION  - version string (e.g. 22.04, 38)
#   DISTRO_FAMILY   - distro family (debian, redhat, arch, suse, other)
#   PKG_MANAGER     - package manager command (apt, dnf, pacman, zypper)
detect_distro() {
    DISTRO_ID="unknown"
    DISTRO_VERSION="unknown"
    DISTRO_FAMILY="other"
    PKG_MANAGER="unknown"

    if [[ -f /etc/os-release ]]; then
        # shellcheck source=/dev/null
        . /etc/os-release
        DISTRO_ID="${ID:-unknown}"
        DISTRO_VERSION="${VERSION_ID:-unknown}"
    elif [[ -f /etc/lsb-release ]]; then
        # shellcheck source=/dev/null
        . /etc/lsb-release
        DISTRO_ID="${DISTRIB_ID:-unknown}"
        DISTRO_VERSION="${DISTRIB_RELEASE:-unknown}"
        DISTRO_ID="${DISTRO_ID,,}"
    elif [[ -f /etc/debian_version ]]; then
        DISTRO_ID="debian"
        DISTRO_VERSION="$(cat /etc/debian_version)"
    elif [[ -f /etc/redhat-release ]]; then
        DISTRO_ID="rhel"
        DISTRO_VERSION="$(grep -oP '[\d.]+' /etc/redhat-release | head -1)"
    elif [[ -f /etc/arch-release ]]; then
        DISTRO_ID="arch"
        DISTRO_VERSION="rolling"
    elif [[ -f /etc/SuSE-release ]]; then
        DISTRO_ID="opensuse"
        DISTRO_VERSION="$(grep VERSION /etc/SuSE-release | awk '{print $3}')"
    fi

    # Determine distro family
    case "${DISTRO_ID}" in
        ubuntu|linuxmint|pop|elementary|zorin|neon|kubuntu|xubuntu|lubuntu)
            DISTRO_FAMILY="debian"
            PKG_MANAGER="apt"
            ;;
        debian|raspbian|mx|antix|kali|parrot|devuan)
            DISTRO_FAMILY="debian"
            PKG_MANAGER="apt"
            ;;
        fedora|rhel|centos|almalinux|rocky|ol|scientific|nobara)
            DISTRO_FAMILY="redhat"
            PKG_MANAGER="dnf"
            # Older CentOS/RHEL 7 use yum
            if ! command -v dnf &>/dev/null && command -v yum &>/dev/null; then
                PKG_MANAGER="yum"
            fi
            ;;
        arch|endeavouros|garuda|arcolinux|artix|blackarch|crystal|hyperbola|parabola)
            DISTRO_FAMILY="arch"
            PKG_MANAGER="pacman"
            ;;
        manjaro)
            DISTRO_FAMILY="arch"
            PKG_MANAGER="pamac"
            if ! command -v pamac &>/dev/null; then
                PKG_MANAGER="pacman"
            fi
            ;;
        opensuse*|sles|sled)
            DISTRO_FAMILY="suse"
            PKG_MANAGER="zypper"
            ;;
        gentoo)
            DISTRO_FAMILY="gentoo"
            PKG_MANAGER="emerge"
            ;;
        void)
            DISTRO_FAMILY="void"
            PKG_MANAGER="xbps-install"
            ;;
        alpine)
            DISTRO_FAMILY="alpine"
            PKG_MANAGER="apk"
            ;;
        *)
            DISTRO_FAMILY="other"
            PKG_MANAGER="unknown"
            ;;
    esac

    export DISTRO_ID DISTRO_VERSION DISTRO_FAMILY PKG_MANAGER
}

# Print detected distro info (for testing/debugging)
print_distro_info() {
    detect_distro
    echo "Distribution ID:      ${DISTRO_ID}"
    echo "Distribution Version: ${DISTRO_VERSION}"
    echo "Distribution Family:  ${DISTRO_FAMILY}"
    echo "Package Manager:      ${PKG_MANAGER}"
}

# If called directly (not sourced), print the info
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    print_distro_info
fi
