# Simplicity Theme — Ubuntu / Linux Mint / Pop!_OS

This directory contains the installer script for Ubuntu-based distributions.

## Supported Distributions

| Distribution     | Versions         | Desktop Environments          |
|-----------------|------------------|-------------------------------|
| Ubuntu          | 20.04, 22.04, 24.04 | GNOME, XFCE, MATE, KDE       |
| Linux Mint      | 20, 21           | Cinnamon, XFCE, MATE          |
| Pop!_OS         | 20.04, 22.04     | GNOME (COSMIC)                |
| elementaryOS    | 6, 7             | Pantheon                      |
| Zorin OS        | 16, 17           | GNOME                         |

## Installation

```bash
chmod +x install.sh
./install.sh
```

## Manual Installation

1. Copy the `simplicity-dark/` folder from the repository root to `~/.themes/Simplicity-Dark/`
2. Open **GNOME Tweaks** → **Appearance** → set **Shell** and **Legacy Applications** to `Simplicity`
3. Or use `gsettings`:

```bash
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity-Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity-Dark"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

## Dependencies

The installer will automatically install:
- `gnome-tweaks` — theme manager GUI
- `gtk2-engines-murrine` — GTK 2 theme engine
- `gtk2-engines-pixbuf` — GTK 2 pixbuf engine
- `sassc` — SCSS compiler (optional)

## Uninstallation

```bash
rm -rf ~/.themes/"Simplicity-Dark"
gsettings reset org.gnome.desktop.interface gtk-theme
gsettings reset org.gnome.desktop.wm.preferences theme
```
