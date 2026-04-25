#!/usr/bin/env bash
# uninstall.sh — Simplicity Theme Suite Uninstaller
# Removes the Simplicity theme and resets desktop environment settings
#
# Usage: ./uninstall.sh [--system] [--keep-settings] [--help]

set -euo pipefail

THEME_NAME="Simplicity"
THEME_DARK_NAME="Simplicity-Dark"
THEME_LIGHT_NAME="Simplicity-Light"
THEME_DRACULA_NAME="Simplicity-Dracula"
ICON_THEME_NAME="Simplicity-Icons"
SYSTEM_UNINSTALL=false
KEEP_SETTINGS=false

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

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --system)
            SYSTEM_UNINSTALL=true
            ;;
        --keep-settings)
            KEEP_SETTINGS=true
            ;;
        --help|-h)
            echo "Simplicity Theme Suite Uninstaller"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --system          Remove from /usr/share/themes (requires root)"
            echo "  --keep-settings   Do not reset desktop environment settings"
            echo "  --help, -h        Show this help message"
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

remove_theme_files() {
    local user_theme_dir="${HOME}/.themes/${THEME_NAME}"
    local system_theme_dir="/usr/share/themes/${THEME_NAME}"
    local user_light_dir="${HOME}/.themes/${THEME_LIGHT_NAME}"
    local system_light_dir="/usr/share/themes/${THEME_LIGHT_NAME}"
    local user_dark_dir="${HOME}/.themes/${THEME_DARK_NAME}"
    local system_dark_dir="/usr/share/themes/${THEME_DARK_NAME}"
    local user_dracula_dir="${HOME}/.themes/${THEME_DRACULA_NAME}"
    local system_dracula_dir="/usr/share/themes/${THEME_DRACULA_NAME}"

    if [[ -d "${user_theme_dir}" ]]; then
        info "Removing user theme directory: ${user_theme_dir}"
        rm -rf "${user_theme_dir}"
        success "Removed: ${user_theme_dir}"
    else
        info "User theme directory not found: ${user_theme_dir}"
    fi

    if [[ -d "${user_light_dir}" ]]; then
        info "Removing user light theme directory: ${user_light_dir}"
        rm -rf "${user_light_dir}"
        success "Removed: ${user_light_dir}"
    fi

    if [[ -d "${user_dark_dir}" ]]; then
        info "Removing user dark theme directory: ${user_dark_dir}"
        rm -rf "${user_dark_dir}"
        success "Removed: ${user_dark_dir}"
    fi

    if [[ -d "${user_dracula_dir}" ]]; then
        info "Removing user Dracula theme directory: ${user_dracula_dir}"
        rm -rf "${user_dracula_dir}"
        success "Removed: ${user_dracula_dir}"
    fi

    if "${SYSTEM_UNINSTALL}"; then
        if [[ -d "${system_theme_dir}" ]]; then
            if [[ "${EUID}" -ne 0 ]]; then
                die "Removing system theme requires root privileges. Run with sudo."
            fi
            info "Removing system theme directory: ${system_theme_dir}"
            rm -rf "${system_theme_dir}"
            success "Removed: ${system_theme_dir}"
        else
            info "System theme directory not found: ${system_theme_dir}"
        fi

        if [[ -d "${system_light_dir}" ]]; then
            info "Removing system light theme directory: ${system_light_dir}"
            rm -rf "${system_light_dir}"
            success "Removed: ${system_light_dir}"
        fi

        if [[ -d "${system_dark_dir}" ]]; then
            info "Removing system dark theme directory: ${system_dark_dir}"
            rm -rf "${system_dark_dir}"
            success "Removed: ${system_dark_dir}"
        fi

        if [[ -d "${system_dracula_dir}" ]]; then
            info "Removing system Dracula theme directory: ${system_dracula_dir}"
            rm -rf "${system_dracula_dir}"
            success "Removed: ${system_dracula_dir}"
        fi
    fi
}

remove_icon_theme() {
    local user_icon_dir="${HOME}/.local/share/icons/${ICON_THEME_NAME}"
    local system_icon_dir="/usr/share/icons/${ICON_THEME_NAME}"

    if [[ -d "${user_icon_dir}" ]]; then
        info "Removing user icon theme directory: ${user_icon_dir}"
        rm -rf "${user_icon_dir}"
        success "Removed: ${user_icon_dir}"
    else
        info "User icon theme directory not found: ${user_icon_dir}"
    fi

    if "${SYSTEM_UNINSTALL}"; then
        if [[ -d "${system_icon_dir}" ]]; then
            if [[ "${EUID}" -ne 0 ]]; then
                die "Removing system icon theme requires root privileges. Run with sudo."
            fi
            info "Removing system icon theme directory: ${system_icon_dir}"
            rm -rf "${system_icon_dir}"
            success "Removed: ${system_icon_dir}"
        else
            info "System icon theme directory not found: ${system_icon_dir}"
        fi
    fi
}

reset_gsettings() {
    if "${KEEP_SETTINGS}"; then
        info "Keeping desktop settings (--keep-settings specified)."
        return
    fi

    if command -v gsettings &>/dev/null; then
        info "Resetting GNOME/GTK settings..."
        gsettings reset org.gnome.desktop.interface gtk-theme 2>/dev/null || true
        gsettings reset org.gnome.desktop.wm.preferences theme 2>/dev/null || true
        gsettings reset org.gnome.desktop.interface color-scheme 2>/dev/null || true
        gsettings reset org.gnome.desktop.interface icon-theme 2>/dev/null || true
        gsettings reset org.gnome.shell.extensions.user-theme name 2>/dev/null || true
        success "GNOME settings reset."
    fi
}

reset_mate_settings() {
    if "${KEEP_SETTINGS}"; then
        return
    fi

    if command -v gsettings &>/dev/null; then
        gsettings reset org.mate.interface gtk-theme 2>/dev/null || true
        gsettings reset org.mate.Marco.general theme 2>/dev/null || true
    fi
}

reset_cinnamon_settings() {
    if "${KEEP_SETTINGS}"; then
        return
    fi

    if command -v gsettings &>/dev/null; then
        gsettings reset org.cinnamon.desktop.interface gtk-theme 2>/dev/null || true
        gsettings reset org.cinnamon.desktop.wm.preferences theme 2>/dev/null || true
        gsettings reset org.cinnamon.theme name 2>/dev/null || true
    fi
}

reset_xfce_settings() {
    if "${KEEP_SETTINGS}"; then
        return
    fi

    if command -v xfconf-query &>/dev/null; then
        info "Resetting XFCE settings..."
        xfconf-query -c xsettings -p /Net/ThemeName -r 2>/dev/null || true
        xfconf-query -c xsettings -p /Net/IconThemeName -r 2>/dev/null || true
        xfconf-query -c xfwm4 -p /general/theme -r 2>/dev/null || true
        success "XFCE settings reset."
    fi
}

remove_gtk_settings() {
    if "${KEEP_SETTINGS}"; then
        return
    fi

    local gtk3_settings="${HOME}/.config/gtk-3.0/settings.ini"
    local gtk4_settings="${HOME}/.config/gtk-4.0/settings.ini"

    for settings_file in "${gtk3_settings}" "${gtk4_settings}"; do
        if [[ -f "${settings_file}" ]]; then
            if grep -qE "^gtk-theme-name=(${THEME_NAME}|${THEME_LIGHT_NAME}|${THEME_DARK_NAME}|${THEME_DRACULA_NAME})" "${settings_file}" 2>/dev/null; then
                info "Removing Simplicity settings from: ${settings_file}"
                # Remove only the Simplicity-specific lines, keep other settings
                sed -i \
                    -e "/^gtk-theme-name=${THEME_NAME}/d" \
                    -e "/^gtk-theme-name=${THEME_LIGHT_NAME}/d" \
                    -e "/^gtk-theme-name=${THEME_DARK_NAME}/d" \
                    -e "/^gtk-theme-name=${THEME_DRACULA_NAME}/d" \
                    -e "/^gtk-icon-theme-name=Simplicity-Icons/d" \
                    -e "/^gtk-cursor-theme-name=Simplicity-Cursors/d" \
                    -e "/^gtk-application-prefer-dark-theme=1/d" \
                    -e "/^gtk-application-prefer-dark-theme=0/d" \
                    "${settings_file}"
                # If the file is now empty (just [Settings] header), remove it
                if [[ "$(grep -cv '^\[' "${settings_file}" 2>/dev/null || echo 0)" -eq 0 ]]; then
                    rm -f "${settings_file}"
                    success "Removed empty settings file: ${settings_file}"
                else
                    success "Removed Simplicity entries from: ${settings_file}"
                fi
            fi
        fi
    done
}

main() {
    echo ""
    echo -e "${RED}"
    echo "  Simplicity — Uninstaller"
    echo -e "${NC}"
    echo ""

    info "Removing Simplicity theme files..."
    remove_theme_files
    remove_icon_theme

    info "Resetting desktop settings..."
    reset_gsettings
    reset_mate_settings
    reset_cinnamon_settings
    reset_xfce_settings
    remove_gtk_settings

    echo ""
    success "Simplicity has been uninstalled."
    info "You may need to log out and back in for all changes to take effect."
}

main "$@"
