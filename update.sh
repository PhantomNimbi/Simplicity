#!/usr/bin/env bash
# update.sh — Simplicity Theme Suite Updater
# Refreshes installed Simplicity theme files from the repository without
# changing any desktop-environment settings.
#
# Usage: ./update.sh [--system] [--no-apply] [--dark] [--light] [--dracula] [--help]
#
# Options:
#   --system      Update the system-wide installation in /usr/share/themes
#                 (requires root) instead of the user installation in ~/.themes
#   --no-apply    Update files only; do not re-apply the theme to the current
#                 session
#   --dark        Also update the Simplicity-Dark variant (if installed)
#   --light       Also update the Simplicity-Light variant (if installed)
#   --dracula     Also update the Simplicity-Dracula variant (if installed)
#   --help        Show this help message

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="Simplicity"
THEME_DARK_NAME="Simplicity-Dark"
THEME_LIGHT_NAME="Simplicity-Light"
THEME_DRACULA_NAME="Simplicity-Dracula"
SYSTEM_INSTALL=false
NO_APPLY=false
UPDATE_DARK=false
UPDATE_LIGHT=false
UPDATE_DRACULA=false

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
        --dark)
            UPDATE_DARK=true
            ;;
        --light)
            UPDATE_LIGHT=true
            ;;
        --dracula)
            UPDATE_DRACULA=true
            ;;
        --help|-h)
            echo "Simplicity Theme Suite Updater"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --system      Update the system installation in /usr/share/themes (requires root)"
            echo "  --no-apply    Update files only; do not re-apply the theme"
            echo "  --dark        Also update the Simplicity-Dark variant"
            echo "  --light       Also update the Simplicity-Light variant"
            echo "  --dracula     Also update the Simplicity-Dracula variant"
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

update_variant() {
    local variant_name="$1"   # installed directory name, e.g. Simplicity
    local source_dir="$2"     # source directory in the repo

    local target_dir
    if "${SYSTEM_INSTALL}"; then
        target_dir="/usr/share/themes/${variant_name}"
    else
        target_dir="${HOME}/.themes/${variant_name}"
    fi

    if [[ ! -d "${target_dir}" ]]; then
        warning "Theme '${variant_name}' is not installed at ${target_dir}. Skipping."
        return
    fi

    info "Updating ${variant_name} at ${target_dir}..."
    cp -r "${source_dir}/." "${target_dir}/"
    success "Updated: ${target_dir}"
}

update_theme_files() {
    if "${SYSTEM_INSTALL}" && [[ "${EUID}" -ne 0 ]]; then
        die "System update requires root privileges. Run with sudo."
    fi

    update_variant "${THEME_NAME}" "${SCRIPT_DIR}/simplicity-dualtone"

    if "${UPDATE_LIGHT}"; then
        update_variant "${THEME_LIGHT_NAME}" "${SCRIPT_DIR}/simplicity-light"
    fi

    if "${UPDATE_DARK}"; then
        update_variant "${THEME_DARK_NAME}" "${SCRIPT_DIR}/simplicity-dark"
    fi

    if "${UPDATE_DRACULA}"; then
        update_variant "${THEME_DRACULA_NAME}" "${SCRIPT_DIR}/simplicity-dracula"
    fi
}

apply_theme() {
    if "${NO_APPLY}"; then
        info "Skipping theme re-application (--no-apply specified)."
        return
    fi

    if [[ -f "${SCRIPT_DIR}/scripts/apply-theme.sh" ]]; then
        info "Re-applying theme to current desktop session..."
        bash "${SCRIPT_DIR}/scripts/apply-theme.sh"
    fi
}

main() {
    echo ""
    echo -e "${BLUE}"
    echo "  Simplicity — Updater"
    echo -e "${NC}"
    echo ""

    header "Step 1/2: Updating theme files..."
    update_theme_files
    echo ""

    header "Step 2/2: Re-applying theme..."
    apply_theme
    echo ""

    success "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    success "  Simplicity update complete!"
    success "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    info "To uninstall, run: ./uninstall.sh"
    info "For help, see: README.md"
    echo ""
}

main "$@"
