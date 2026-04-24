# Installation

> 🌐 **Translate this page:**
> [🇪🇸 Español](https://translate.google.com/translate?sl=en&tl=es&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇫🇷 Français](https://translate.google.com/translate?sl=en&tl=fr&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇩🇪 Deutsch](https://translate.google.com/translate?sl=en&tl=de&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇮🇹 Italiano](https://translate.google.com/translate?sl=en&tl=it&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇧🇷 Português](https://translate.google.com/translate?sl=en&tl=pt&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇷🇺 Русский](https://translate.google.com/translate?sl=en&tl=ru&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇨🇳 中文](https://translate.google.com/translate?sl=en&tl=zh-CN&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇯🇵 日本語](https://translate.google.com/translate?sl=en&tl=ja&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇰🇷 한국어](https://translate.google.com/translate?sl=en&tl=ko&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇸🇦 العربية](https://translate.google.com/translate?sl=en&tl=ar&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md) ·
> [🇮🇳 हिन्दी](https://translate.google.com/translate?sl=en&tl=hi&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Installation.md)

This page provides a comprehensive installation guide covering automatic installation, manual installation, system-wide installation, installing additional variants, applying or switching themes, and uninstalling.

---

## Prerequisites

Before installing, make sure you have the following packages available. The installer will attempt to install them automatically when it detects a supported distribution.

| Package | Purpose |
|---------|---------|
| `gtk2-engines-murrine` / `gtk-engine-murrine` | GTK 2 Murrine engine (required for GTK 2 rendering) |
| `gtk2-engines-pixbuf` / `gtk2-engines` | GTK 2 Pixbuf engine |
| `gnome-themes-extra` | Additional GNOME theme assets (Ubuntu/Debian) |

If you're on an unsupported distribution, install the equivalent packages for your package manager before running the installer.

---

## Method 1 — Automatic Installation (Recommended)

The automatic installer detects your Linux distribution and desktop environment, installs all required dependencies, copies the theme files, and applies the theme to your current session.

### Step 1 — Clone the repository

```bash
git clone https://github.com/PhantomNimbi/Simplicity.git
cd Simplicity
```

### Step 2 — Make the installer executable

```bash
chmod +x install.sh
```

### Step 3 — Run the installer

```bash
./install.sh
```

The installer will:
1. Print the detected distribution, version, and package manager
2. Copy the **Simplicity** (dual-tone) theme files to `~/.themes/Simplicity/`
3. Install the required GTK engine packages via your package manager
4. Apply the theme to your current desktop session

**Expected output:**

```
  ██████╗ ███████╗███████╗██╗  ██╗████████╗██╗  ██╗███████╗███╗   ███╗
  ...

  Step 1/3: Detecting your system...
  [INFO]  OS: ubuntu 24.04 (debian family)
  [INFO]  Package manager: apt

  Step 2/3: Installing theme files...
  [INFO]  Installing to user directory: /home/user/.themes/Simplicity
  [OK]    Theme files installed to: /home/user/.themes/Simplicity

  Step 3/3: Installing dependencies and applying theme...
  [INFO]  Running distribution-specific installer...
  [INFO]  Applying theme to current desktop session...

  [OK]    Simplicity installation complete!
```

---

## Method 2 — Automatic Installation with Additional Variants

To install the Light and/or Dark variants in addition to the default Dual-Tone variant:

```bash
# Install all three variants
./install.sh --dark --light
```

After this, your `~/.themes/` directory will contain:

```
~/.themes/
├── Simplicity/          ← Dual-Tone (default)
├── Simplicity-Dark/     ← Full dark
└── Simplicity-Light/    ← Full light
```

---

## Method 3 — Manual Installation

Use this method if the automatic installer does not support your distribution, or if you want full control over where files are placed.

### Step 1 — Clone the repository

```bash
git clone https://github.com/PhantomNimbi/Simplicity.git
```

### Step 2 — Install required packages

Install the GTK engine packages for your distribution:

**Ubuntu / Debian / Mint / Pop!_OS / Kali:**
```bash
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf gnome-themes-extra
```

**Fedora / RHEL / CentOS / AlmaLinux:**
```bash
sudo dnf install gtk-murrine-engine gtk2-engines
```

**Arch Linux / EndeavourOS / Garuda:**
```bash
sudo pacman -S gtk-engine-murrine gtk-engines
# or with AUR helper:
yay -S gtk-engine-murrine gtk-engines
```

**Manjaro:**
```bash
pamac install gtk-engine-murrine gtk-engines
```

**openSUSE Leap / Tumbleweed:**
```bash
sudo zypper install gtk2-engine-murrine gtk2-engines
```

### Step 3 — Copy the theme files

Copy the desired variant to your themes directory:

**Dual-Tone (default):**
```bash
cp -r Simplicity/simplicity-dualtone ~/.themes/Simplicity
```

**Dark variant:**
```bash
cp -r Simplicity/simplicity-dark ~/.themes/Simplicity-Dark
```

**Light variant:**
```bash
cp -r Simplicity/simplicity-light ~/.themes/Simplicity-Light
```

### Step 4 — Apply the theme

See [Method 4: Applying the Theme Manually](#method-4--applying-the-theme-manually) below for per-DE application commands.

---

## Method 4 — Applying the Theme Manually

After installation, use the `apply-theme.sh` script or apply via your desktop environment's settings.

### Using the apply-theme script

```bash
# Apply the default dual-tone variant
./scripts/apply-theme.sh

# Apply the dark variant
./scripts/apply-theme.sh --dark

# Apply the light variant
./scripts/apply-theme.sh --light

# Preview what would happen without making changes
./scripts/apply-theme.sh --dry-run
./scripts/apply-theme.sh --dark --dry-run
```

### GNOME

```bash
# Dual-Tone
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

# Dark
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity-Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity-Dark"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Light
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity-Light"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity-Light"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
```

For the GNOME shell theme, install the [User Themes](https://extensions.gnome.org/extension/19/user-themes/) extension and then:

```bash
gsettings set org.gnome.shell.extensions.user-theme name "Simplicity"
```

### XFCE

```bash
xfconf-query -c xsettings -p /Net/ThemeName -s "Simplicity"
xfconf-query -c xfwm4 -p /general/theme -s "Simplicity"
```

Or via the GUI: **Settings → Appearance** (Widget tab) and **Settings → Window Manager** (Style tab).

### MATE

```bash
gsettings set org.mate.interface gtk-theme "Simplicity"
gsettings set org.mate.Marco.general theme "Simplicity"
```

### Cinnamon

```bash
gsettings set org.cinnamon.desktop.interface gtk-theme "Simplicity"
gsettings set org.cinnamon.desktop.wm.preferences theme "Simplicity"
gsettings set org.cinnamon.theme name "Simplicity"
```

### KDE Plasma

KDE uses its own theming system for the shell, but GTK applications inside KDE can use the Simplicity GTK theme.

1. Go to **System Settings → Appearance → Application Style**
2. Click **Configure GNOME/GTK Application Style…**
3. Select **Simplicity** from the theme dropdown

Or set it via the GTK settings file:

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

### LXDE / LXQt

Go to **Preferences → Appearance Settings → Widget** tab and select **Simplicity**.

Or set it via the GTK settings file (same as KDE above).

### i3 / Sway / Openbox / Tiling WMs

Write the GTK settings file manually:

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-icon-theme-name=Simplicity-Icons
gtk-font-name=Sans 10
gtk-application-prefer-dark-theme=0
```

```ini
# ~/.config/gtk-4.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

---

## System-Wide Installation

To install Simplicity for all users on the system (writes to `/usr/share/themes/` instead of `~/.themes/`):

```bash
sudo ./install.sh --system
```

To include additional variants system-wide:

```bash
sudo ./install.sh --system --dark --light
```

This requires root privileges. The `--system` flag automatically verifies that the installer is running as root and will exit with an error if it is not.

---

## Installer Reference

```
./install.sh [OPTIONS]

Options:
  --system      Install to /usr/share/themes (requires root) instead of ~/.themes
  --no-apply    Install files only; do not apply the theme to the current session
  --dark        Also install the Simplicity-Dark (full dark) variant
  --light       Also install the Simplicity-Light (full light) variant
  --help, -h    Show this help message
```

| Flag | Effect |
|------|--------|
| *(no flags)* | Installs Simplicity (dual-tone) to `~/.themes/` and applies it |
| `--system` | Installs to `/usr/share/themes/` (requires `sudo`) |
| `--no-apply` | Copies files but skips applying the theme |
| `--dark` | Also installs `Simplicity-Dark` |
| `--light` | Also installs `Simplicity-Light` |
| `--dark --light` | Installs all three variants |

---

## Apply-Theme Script Reference

```
./scripts/apply-theme.sh [OPTIONS]

Options:
  --dry-run, -n   Show what would be done without making changes
  --light         Apply the Simplicity-Light theme
  --dark          Apply the Simplicity-Dark theme
  --help, -h      Show this help message
```

The script auto-detects your desktop environment via `$XDG_CURRENT_DESKTOP` and runs the appropriate commands (`gsettings`, `xfconf-query`, or falls back to writing GTK settings files).

---

## Uninstallation

To remove Simplicity from your user account and reset desktop settings:

```bash
./uninstall.sh
```

To remove a system-wide installation:

```bash
sudo ./uninstall.sh --system
```

To remove the theme files but keep your desktop environment settings unchanged:

```bash
./uninstall.sh --keep-settings
```

**Manual uninstall:**

```bash
# Remove theme directories
rm -rf ~/.themes/Simplicity
rm -rf ~/.themes/Simplicity-Dark
rm -rf ~/.themes/Simplicity-Light

# Reset GNOME settings
gsettings reset org.gnome.desktop.interface gtk-theme
gsettings reset org.gnome.desktop.wm.preferences theme
gsettings reset org.gnome.desktop.interface color-scheme

# Reset XFCE settings
xfconf-query -c xsettings -p /Net/ThemeName -r
xfconf-query -c xfwm4 -p /general/theme -r
```

---

## Distribution-Specific Notes

### Ubuntu / Linux Mint / Pop!_OS / Elementary OS

No special steps are required. The installer handles `apt` and all package names automatically.

### Debian / MX Linux / Kali / Parrot

Same as Ubuntu. If `gnome-themes-extra` is not available on your version of Debian, the engine packages alone are sufficient for GTK 3 and GTK 4 functionality.

### Fedora / RHEL 9+ / AlmaLinux / Rocky Linux

On Fedora, `dnf` is used. On older RHEL/CentOS 7 systems, the installer falls back to `yum` automatically.

### Arch Linux / EndeavourOS / Garuda

The installer uses `pacman`. If `yay` or another AUR helper is available, it will be preferred for AUR packages. Core packages (`gtk-engine-murrine`, `gtk-engines`) are available in the official `extra` repository.

### Manjaro

The installer prefers `pamac`. If `pamac` is not found it falls back to `pacman`.

### openSUSE Leap / Tumbleweed

Package names differ slightly (`gtk2-engine-murrine` vs `gtk-engine-murrine`). The openSUSE-specific installer handles this automatically.

### Other Distributions (Gentoo, Void, Alpine, etc.)

The main installer will print a warning for unrecognised distributions and attempt a generic installation (theme file copy only, no dependency installation). Install the GTK Murrine and Pixbuf engine packages manually using your distribution's package manager before running the installer.

---

## Verifying the Installation

After installation, confirm the theme files are present:

```bash
ls ~/.themes/Simplicity/
# Expected output:
# gtk-2.0  gtk-3.0  gtk-4.0  index.theme  metacity-1  openbox-3  xfwm4
```

To preview what `apply-theme.sh` would do without making changes:

```bash
./scripts/apply-theme.sh --dry-run
```

Then apply and log out / log back in if full effect is not immediately visible:

```bash
./scripts/apply-theme.sh
# Log out and back in if needed
```
