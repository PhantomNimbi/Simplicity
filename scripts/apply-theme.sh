#!/usr/bin/env bash
# apply-theme.sh — Apply the Simplicity theme to the current desktop environment
# Part of the Simplicity theme suite
#
# Usage: ./scripts/apply-theme.sh [--dry-run]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
THEME_NAME="Simplicity"
DRY_RUN=false

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
success() { echo -e "${GREEN}[OK]${NC}    $*"; }
warning() { echo -e "${YELLOW}[WARN]${NC}  $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }

run_cmd() {
    if "${DRY_RUN}"; then
        info "[DRY-RUN] Would run: $*"
    else
        "$@"
    fi
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run|-n)
            DRY_RUN=true
            info "Dry-run mode enabled. No changes will be made."
            ;;
        --help|-h)
            echo "Usage: $0 [--dry-run]"
            echo ""
            echo "Options:"
            echo "  --dry-run, -n   Show what would be done without making changes"
            echo "  --help, -h      Show this help message"
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Detect desktop environment
detect_desktop() {
    local de="${XDG_CURRENT_DESKTOP:-}"
    if [[ -z "${de}" ]]; then
        de="${DESKTOP_SESSION:-}"
    fi
    echo "${de,,}"
}

# Check if theme is installed
check_theme_installed() {
    local theme_dir="${HOME}/.themes/${THEME_NAME}"
    local system_theme_dir="/usr/share/themes/${THEME_NAME}"
    if [[ -d "${theme_dir}" ]] || [[ -d "${system_theme_dir}" ]]; then
        return 0
    fi
    return 1
}

# Apply theme to GNOME
apply_gnome() {
    info "Applying Simplicity to GNOME..."
    run_cmd gsettings set org.gnome.desktop.interface gtk-theme "${THEME_NAME}"
    run_cmd gsettings set org.gnome.desktop.wm.preferences theme "${THEME_NAME}"
    run_cmd gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    # Try to apply shell theme if user-theme extension is active
    run_cmd bash -c "gsettings set org.gnome.shell.extensions.user-theme name '${THEME_NAME}' 2>/dev/null || true"
    success "GNOME theme applied."
}

# Apply theme to XFCE
apply_xfce() {
    info "Applying Simplicity to XFCE..."
    run_cmd xfconf-query -c xsettings -p /Net/ThemeName -s "${THEME_NAME}"
    run_cmd xfconf-query -c xfwm4 -p /general/theme -s "${THEME_NAME}"
    success "XFCE theme applied."
}

# Apply theme to MATE
apply_mate() {
    info "Applying Simplicity to MATE..."
    run_cmd gsettings set org.mate.interface gtk-theme "${THEME_NAME}"
    run_cmd gsettings set org.mate.Marco.general theme "${THEME_NAME}"
    success "MATE theme applied."
}

# Apply theme to Cinnamon
apply_cinnamon() {
    info "Applying Simplicity to Cinnamon..."
    run_cmd gsettings set org.cinnamon.desktop.interface gtk-theme "${THEME_NAME}"
    run_cmd gsettings set org.cinnamon.desktop.wm.preferences theme "${THEME_NAME}"
    run_cmd gsettings set org.cinnamon.theme name "${THEME_NAME}"
    success "Cinnamon theme applied."
}

# Apply theme via GTK settings file (universal fallback)
apply_gtk_settings() {
    info "Applying Simplicity via GTK settings file..."
    local gtk3_dir="${HOME}/.config/gtk-3.0"
    local gtk4_dir="${HOME}/.config/gtk-4.0"

    run_cmd mkdir -p "${gtk3_dir}" "${gtk4_dir}"

    if ! "${DRY_RUN}"; then
        for gtk_dir in "${gtk3_dir}" "${gtk4_dir}"; do
            local settings_file
            settings_file="${gtk_dir}/settings.ini"
            if [[ -f "${settings_file}" ]]; then
                # Back up existing settings and merge only the theme-related keys
                cp "${settings_file}" "${settings_file}.bak"
                # Update or add gtk-theme-name
                if grep -q "^gtk-theme-name=" "${settings_file}"; then
                    sed -i "s|^gtk-theme-name=.*|gtk-theme-name=${THEME_NAME}|" "${settings_file}"
                else
                    sed -i '/^\[Settings\]/a gtk-theme-name='"${THEME_NAME}" "${settings_file}"
                fi
                # Update or add gtk-application-prefer-dark-theme
                if grep -q "^gtk-application-prefer-dark-theme=" "${settings_file}"; then
                    sed -i "s|^gtk-application-prefer-dark-theme=.*|gtk-application-prefer-dark-theme=1|" "${settings_file}"
                else
                    sed -i '/^\[Settings\]/a gtk-application-prefer-dark-theme=1' "${settings_file}"
                fi
            else
                cat > "${settings_file}" << EOINI
[Settings]
gtk-theme-name=${THEME_NAME}
gtk-icon-theme-name=Simplicity-Icons
gtk-font-name=Sans 10
gtk-cursor-theme-name=Simplicity-Cursors
gtk-application-prefer-dark-theme=1
EOINI
            fi
        done
    fi

    success "GTK settings files written."
}

main() {
    local desktop
    desktop="$(detect_desktop)"
    info "Detected desktop environment: ${desktop:-unknown}"

    if ! check_theme_installed; then
        error "Theme '${THEME_NAME}' is not installed."
        error "Run install.sh first to install the theme."
        exit 1
    fi

    case "${desktop}" in
        *gnome*|*unity*)
            apply_gnome
            ;;
        *xfce*)
            apply_xfce
            apply_gtk_settings
            ;;
        *mate*)
            apply_mate
            apply_gtk_settings
            ;;
        *cinnamon*)
            apply_cinnamon
            apply_gtk_settings
            ;;
        *kde*|*plasma*)
            info "KDE Plasma detected."
            info "Please apply the GTK theme via:"
            info "  System Settings → Appearance → Application Style → Configure GNOME/GTK Applications"
            apply_gtk_settings
            ;;
        *lxde*|*lxqt*)
            info "LXDE/LXQt detected."
            info "Please apply the theme via:"
            info "  Preferences → Appearance Settings → Widget tab"
            apply_gtk_settings
            ;;
        *i3*|*sway*|*bspwm*|*openbox*|*awesome*|*dwm*)
            info "Tiling/minimal WM detected."
            apply_gtk_settings
            ;;
        *)
            warning "Desktop environment '${desktop}' not specifically supported."
            info "Applying via GTK settings file as fallback..."
            apply_gtk_settings
            ;;
    esac

    echo ""
    success "Simplicity theme applied successfully!"
    info "You may need to log out and back in for all changes to take full effect."
}

main "$@"
