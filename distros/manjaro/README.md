# Deskthem Theme — Manjaro Linux

This directory contains the installer script for Manjaro Linux.

## Supported Editions

| Edition          | Desktop Environment   | Notes                        |
|-----------------|----------------------|------------------------------|
| Manjaro GNOME   | GNOME                | Full GTK 3/4 support         |
| Manjaro KDE     | KDE Plasma           | GTK theme for Qt-GTK bridge  |
| Manjaro XFCE    | XFCE                 | Full XFWM4 + GTK 3 support   |
| Manjaro Cinnamon | Cinnamon             | GTK 3 support                |
| Manjaro i3      | i3 WM                | GTK 3 settings file          |

## Installation

```bash
chmod +x install.sh
./install.sh
```

## Manual Installation

1. Copy the `deskthem/` folder from the repository root to `~/.themes/Deskthem/`
2. Apply using pamac or the command line:

### GNOME
```bash
gsettings set org.gnome.desktop.interface gtk-theme "Deskthem"
gsettings set org.gnome.desktop.wm.preferences theme "Deskthem"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### XFCE
```bash
xfconf-query -c xsettings -p /Net/ThemeName -s "Deskthem"
xfconf-query -c xfwm4 -p /general/theme -s "Deskthem"
```

### KDE Plasma
1. Open **System Settings** → **Appearance** → **Application Style**
2. Set GTK theme to **Deskthem**

### GTK Settings File (i3, Sway, etc.)
```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Deskthem
gtk-application-prefer-dark-theme=1
```

## Pamac vs Pacman

Manjaro ships with `pamac` as the default package manager GUI, but `pacman` is also available. The installer detects which one to use.

## Uninstallation

```bash
rm -rf ~/.themes/Deskthem
gsettings reset org.gnome.desktop.interface gtk-theme
```
