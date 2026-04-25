# Simplicity Theme — Arch Linux / EndeavourOS / Garuda Linux

This directory contains the installer script for Arch Linux and Arch-based distributions.

## Supported Distributions

| Distribution     | Type      | Desktop Environments                     |
|-----------------|-----------|------------------------------------------|
| Arch Linux      | Rolling   | GNOME, KDE Plasma, XFCE, i3, Sway, etc. |
| EndeavourOS     | Rolling   | GNOME, KDE, XFCE, i3, Budgie, etc.      |
| Garuda Linux    | Rolling   | KDE Plasma, GNOME, XFCE, i3, Sway       |
| ArcoLinux       | Rolling   | XFCE, i3, Openbox, and many more         |
| Manjaro         | Semi-Rolling | GNOME, KDE, XFCE                      |

## Installation

```bash
chmod +x install.sh
./install.sh
```

## Manual Installation

1. Copy the `simplicity-dualtone/` folder from the repository root to `~/.themes/Simplicity/`
2. Apply the theme using your desktop environment's settings:

### GNOME
```bash
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
```

### XFCE
```bash
xfconf-query -c xsettings -p /Net/ThemeName -s "Simplicity"
xfconf-query -c xfwm4 -p /general/theme -s "Simplicity"
```

### GTK Settings File (universal)
```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

## Dependencies

The installer will install via pacman:
- `gnome-tweaks` — theme manager GUI
- `gtk-engine-murrine` — GTK 2 theme engine
- `gtk-engines` — additional GTK engines
- `sassc` — SCSS compiler (optional)

Optional (via AUR):
- `gnome-shell-extension-user-theme` — for GNOME shell theming

## Uninstallation

```bash
rm -rf ~/.themes/"Simplicity"
gsettings reset org.gnome.desktop.interface gtk-theme
```

## References

- [Arch Wiki: GTK Themes](https://wiki.archlinux.org/title/GTK#Themes)
- [Arch Wiki: Uniform look for Qt and GTK apps](https://wiki.archlinux.org/title/Uniform_look_for_Qt_and_GTK_applications)
