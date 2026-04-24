# Simplicity Theme — openSUSE Leap / Tumbleweed

This directory contains the installer script for openSUSE distributions.

## Supported Distributions

| Distribution         | Versions        | Desktop Environments     |
|---------------------|-----------------|--------------------------|
| openSUSE Leap       | 15.4, 15.5, 15.6 | GNOME, KDE Plasma, XFCE  |
| openSUSE Tumbleweed | Rolling          | GNOME, KDE Plasma, XFCE  |
| SUSE Linux Enterprise | 15+           | GNOME                    |

## Installation

```bash
chmod +x install.sh
./install.sh
```

## Manual Installation

1. Copy the `simplicity-dark/` folder from the repository root to `~/.themes/Simplicity Dark/`
2. Apply using YaST or the command line:

### GNOME
```bash
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity Dark"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### KDE Plasma
1. Open **System Settings** → **Appearance** → **Application Style**
2. Select **Configure GNOME/GTK Application Style**
3. Choose **Simplicity** from the dropdown

## Dependencies

The installer will install via zypper:
- `gnome-tweaks` — theme manager GUI
- `gtk2-engine-murrine` — GTK 2 theme engine
- `sassc` — SCSS compiler (optional)

## Notes

- openSUSE ships with both GNOME and KDE Plasma as primary desktop options.
- YaST provides a graphical tool for managing the system configuration.
- Tumbleweed users get the latest GNOME version with full GTK 4 support.

## Uninstallation

```bash
rm -rf ~/.themes/"Simplicity Dark"
gsettings reset org.gnome.desktop.interface gtk-theme
```
