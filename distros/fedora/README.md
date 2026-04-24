# Simplicity Theme — Fedora / RHEL / CentOS Stream

This directory contains the installer script for Fedora and Red Hat-based distributions.

## Supported Distributions

| Distribution     | Versions     | Desktop Environments              |
|-----------------|--------------|-----------------------------------|
| Fedora          | 36+          | GNOME, KDE Plasma, XFCE           |
| RHEL            | 9+           | GNOME                             |
| CentOS Stream   | 9+           | GNOME                             |
| AlmaLinux       | 9+           | GNOME                             |
| Rocky Linux     | 9+           | GNOME                             |

## Installation

```bash
chmod +x install.sh
./install.sh
```

## Manual Installation

1. Copy the `simplicity-dark/` folder from the repository root to `~/.themes/Simplicity Dark/`
2. Open **GNOME Tweaks** → **Appearance** → set **Legacy Applications** to `Simplicity`
3. Or use `gsettings`:

```bash
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity Dark"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

## Dependencies

The installer will automatically install:
- `gnome-tweaks` — theme manager GUI
- `gtk-murrine-engine` — GTK 2 theme engine
- `sassc` — SCSS compiler (optional)

## Notes

- Fedora ships GNOME by default. GNOME Tweaks is available in the official repositories.
- For KDE Plasma (Fedora KDE spin), see the KDE-specific settings in System Settings → Appearance.
- SELinux may require special handling for system-wide theme installation in `/usr/share/themes/`.

## Uninstallation

```bash
rm -rf ~/.themes/"Simplicity Dark"
gsettings reset org.gnome.desktop.interface gtk-theme
gsettings reset org.gnome.desktop.wm.preferences theme
```
