# Deskthem — Linux Desktop Theme Suite

A clean, modern dark theme suite for Linux desktop environments, with first-class support for all major Linux distributions.

```
  ██████╗ ███████╗███████╗██╗  ██╗████████╗██╗  ██╗███████╗███╗   ███╗
  ██╔══██╗██╔════╝██╔════╝██║ ██╔╝╚══██╔══╝██║  ██║██╔════╝████╗ ████║
  ██║  ██║█████╗  ███████╗█████╔╝    ██║   ███████║█████╗  ██╔████╔██║
  ██║  ██║██╔══╝  ╚════██║██╔═██╗    ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║
  ██████╔╝███████╗███████║██║  ██╗   ██║   ██║  ██║███████╗██║ ╚═╝ ██║
  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝
```

## Features

- 🎨 **GTK 2, 3 & 4** — Full theme support for modern and legacy GTK applications
- 🪟 **Window Managers** — Metacity, XFWM4 (XFCE), and Openbox themes included
- 🐧 **Multi-Distro** — Dedicated installers for 6 major Linux distributions
- 🖥️ **Multi-DE** — Supports GNOME, KDE, XFCE, MATE, Cinnamon, Openbox, i3, Sway
- 🌙 **Dark Theme** — Elegant dark colour palette with blue accent (`#5294e2`)
- 🔧 **Auto-Detection** — Automatically detects your distro and desktop environment

## Colour Palette

| Role               | Colour    |
|--------------------|-----------|
| Background         | `#2d2d2d` |
| Dark Background    | `#252525` |
| Base (inputs)      | `#1e1e1e` |
| Foreground         | `#e0e0e0` |
| Accent / Selected  | `#5294e2` |
| Error / Close btn  | `#cf6679` |
| Warning / Min btn  | `#e5a050` |
| Success / Max btn  | `#4caf50` |
| Borders            | `#404040` |

## Supported Desktop Environments

| Desktop       | GTK 2 | GTK 3 | GTK 4 | WM Theme |
|--------------|:-----:|:-----:|:-----:|:--------:|
| GNOME        | ✅    | ✅    | ✅    | Metacity |
| XFCE         | ✅    | ✅    | —     | XFWM4    |
| MATE         | ✅    | ✅    | —     | Metacity |
| Cinnamon     | ✅    | ✅    | —     | Metacity |
| KDE Plasma   | ✅    | ✅    | ✅    | —        |
| Openbox      | ✅    | ✅    | —     | Openbox  |
| LXDE / LXQt  | ✅    | ✅    | —     | Openbox  |
| i3 / Sway    | ✅    | ✅    | ✅    | —        |

## Supported Linux Distributions

| Distribution              | Installer                        | Package Manager |
|--------------------------|----------------------------------|-----------------|
| Ubuntu / Mint / Pop!_OS  | `distros/ubuntu/install.sh`      | apt             |
| Debian / MX Linux / Kali | `distros/debian/install.sh`      | apt             |
| Fedora / RHEL / CentOS   | `distros/fedora/install.sh`      | dnf             |
| Arch Linux / EndeavourOS | `distros/arch/install.sh`        | pacman / yay    |
| Manjaro Linux            | `distros/manjaro/install.sh`     | pamac / pacman  |
| openSUSE Leap/Tumbleweed | `distros/opensuse/install.sh`    | zypper          |

## Quick Start

### Automatic Installation (Recommended)

```bash
git clone https://github.com/PhantomNimbi/linux-theme.git
cd linux-theme
chmod +x install.sh
./install.sh
```

The installer will:
1. Detect your Linux distribution and desktop environment
2. Install any required dependencies via your package manager
3. Copy theme files to `~/.themes/Deskthem/`
4. Apply the theme to your current session

### Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/PhantomNimbi/linux-theme.git
   ```

2. Copy the theme to your themes directory:
   ```bash
   cp -r linux-theme/deskthem ~/.themes/Deskthem
   ```

3. Apply the theme:

   **GNOME:**
   ```bash
   gsettings set org.gnome.desktop.interface gtk-theme "Deskthem"
   gsettings set org.gnome.desktop.wm.preferences theme "Deskthem"
   gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
   ```

   **XFCE:**
   ```bash
   xfconf-query -c xsettings -p /Net/ThemeName -s "Deskthem"
   xfconf-query -c xfwm4 -p /general/theme -s "Deskthem"
   ```

   **Other / Universal (GTK settings file):**
   ```ini
   # ~/.config/gtk-3.0/settings.ini
   [Settings]
   gtk-theme-name=Deskthem
   gtk-application-prefer-dark-theme=1
   ```

## System-Wide Installation

To install for all users (requires root):

```bash
sudo ./install.sh --system
```

## Installer Options

```
./install.sh [OPTIONS]
  --system      Install to /usr/share/themes (requires root)
  --no-apply    Install files only; do not apply to current session
  --help        Show help
```

## Uninstallation

```bash
./uninstall.sh
```

Or manually:
```bash
rm -rf ~/.themes/Deskthem
gsettings reset org.gnome.desktop.interface gtk-theme
gsettings reset org.gnome.desktop.wm.preferences theme
```

## Repository Structure

```
linux-theme/
├── install.sh                  # Main installer (auto-detects distro)
├── uninstall.sh                # Uninstaller
├── README.md                   # This file
│
├── deskthem/                   # Theme files
│   ├── index.theme             # Theme metadata
│   ├── gtk-2.0/
│   │   └── gtkrc               # GTK 2 theme
│   ├── gtk-3.0/
│   │   ├── gtk.css             # GTK 3 stylesheet
│   │   └── settings.ini        # GTK 3 settings
│   ├── gtk-4.0/
│   │   └── gtk.css             # GTK 4 stylesheet
│   ├── metacity-1/
│   │   └── metacity-theme-3.xml # GNOME/MATE window decorator
│   ├── xfwm4/
│   │   └── themerc             # XFCE window manager theme
│   └── openbox-3/
│       └── themerc             # Openbox window manager theme
│
├── distros/                    # Distribution-specific installers
│   ├── ubuntu/                 # Ubuntu, Mint, Pop!_OS
│   ├── fedora/                 # Fedora, RHEL, CentOS
│   ├── arch/                   # Arch, EndeavourOS, Garuda
│   ├── debian/                 # Debian, MX, Kali
│   ├── opensuse/               # openSUSE Leap & Tumbleweed
│   └── manjaro/                # Manjaro Linux
│
└── scripts/
    ├── detect-distro.sh        # Distro detection helper
    └── apply-theme.sh          # DE-aware theme applicator
```

## Using This Repository as a Template

Want to build your own Linux theme using this project as a starting point? See **[TEMPLATE_USAGE.md](TEMPLATE_USAGE.md)** for a full step-by-step guide covering:

- Creating a repository from this template on GitHub
- Renaming the theme throughout the codebase
- Customising the colour palette
- Updating theme metadata
- Adding or removing distribution support
- Testing your theme before publishing

## Contributing

Contributions are welcome! To add support for a new distribution:

1. Create a new directory under `distros/<distro-name>/`
2. Add an `install.sh` script following the existing pattern
3. Add a `README.md` with distribution-specific notes
4. Update this README with the new distro entry

## License

This project is licensed under the **GNU General Public License v3.0**.
