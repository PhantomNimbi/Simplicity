# Simplicity Theme — Debian / MX Linux / antiX

This directory contains the installer script for Debian and Debian-based distributions.

## Supported Distributions

| Distribution     | Versions               | Desktop Environments     |
|-----------------|------------------------|--------------------------|
| Debian          | 11 (Bullseye), 12 (Bookworm) | GNOME, XFCE, KDE, LXDE |
| MX Linux        | 21+                    | XFCE, KDE, Fluxbox       |
| antiX           | 21+                    | IceWM, Fluxbox           |
| Kali Linux      | Rolling                | XFCE, GNOME              |
| Raspberry Pi OS | Bullseye, Bookworm     | LXDE / XFCE              |

## Installation

```bash
chmod +x install.sh
./install.sh
```

## Manual Installation

1. Copy the `simplicity/` folder from the repository root to `~/.themes/Simplicity/`
2. Apply the theme:

### GNOME
```bash
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity"
```

### XFCE
```bash
xfconf-query -c xsettings -p /Net/ThemeName -s "Simplicity"
xfconf-query -c xfwm4 -p /general/theme -s "Simplicity"
```

### GTK Settings (for lightweight DEs like LXDE, IceWM)
```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=1
```

## Notes

- Debian stable releases may have older GNOME versions. GTK 3 theme is fully compatible.
- For Raspberry Pi OS (LXDE), configure via **Preferences → Appearance Settings**.
- Kali Linux XFCE users: use the **Appearance** panel in XFCE Settings.

## Uninstallation

```bash
rm -rf ~/.themes/Simplicity
gsettings reset org.gnome.desktop.interface gtk-theme
```
