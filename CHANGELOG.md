# Changelog

> 🌐 **Translate this page:**
> [🇪🇸 Español](https://translate.google.com/translate?sl=en&tl=es&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇫🇷 Français](https://translate.google.com/translate?sl=en&tl=fr&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇩🇪 Deutsch](https://translate.google.com/translate?sl=en&tl=de&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇮🇹 Italiano](https://translate.google.com/translate?sl=en&tl=it&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇧🇷 Português](https://translate.google.com/translate?sl=en&tl=pt&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇷🇺 Русский](https://translate.google.com/translate?sl=en&tl=ru&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇨🇳 中文](https://translate.google.com/translate?sl=en&tl=zh-CN&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇯🇵 日本語](https://translate.google.com/translate?sl=en&tl=ja&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇰🇷 한국어](https://translate.google.com/translate?sl=en&tl=ko&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇸🇦 العربية](https://translate.google.com/translate?sl=en&tl=ar&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md) ·
> [🇮🇳 हिन्दी](https://translate.google.com/translate?sl=en&tl=hi&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CHANGELOG.md)

All notable changes to Simplicity are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

---

## [1.1.0] — 2026-04-24

### ✨ Added

#### New Theme Variants

- **Simplicity-Light** (`simplicity-light/`) — Full light palette variant:
  header bar, content area, and chrome all use the light palette.
  GTK 2, GTK 3, GTK 4, Metacity, XFWM4, and Openbox themes included.
- **Dual-Tone default** (`simplicity-dualtone/`) — Combines dark chrome
  (header bar, sidebar, menus, toolbars, OSD) with a light content area
  (window body, text entries, tree views, buttons). This variant replaces
  the original dark theme as the default installation target (`Simplicity`).
  - **GTK 2** (`gtk-2.0/gtkrc`) — Dark menubar and toolbar styles; light
    default widget and button styles.
  - **GTK 3** (`gtk-3.0/gtk.css`) — Dual-palette CSS with `header_bg`/`header_fg`
    colour variables for dark chrome and `bg_color`/`fg_color` for light content.
  - **GTK 3 settings** (`gtk-3.0/settings.ini`) — Sets
    `gtk-application-prefer-dark-theme=0` so the content area renders light.
  - **GTK 4** (`gtk-4.0/gtk.css`) — Adwaita overrides with dark `headerbar_*`,
    `sidebar_*`, and `popover_*` colours alongside light `window_*` and `view_*`
    colours.
  - **Metacity** (`metacity-1/metacity-theme-3.xml`) — Dark titlebar on a light
    window body; same traffic-light button colours as the other variants.
  - **XFWM4** (`xfwm4/themerc`) — Dark active/inactive titlebar colours.
  - **Openbox** (`openbox-3/themerc`) — Dark titlebar and menu chrome.
  - **Theme metadata** (`index.theme`) — Registers `Simplicity` as the
    X-GNOME-Metatheme entry.

#### Documentation

- **GitHub Wiki** — Comprehensive wiki added with pages for Home, Theme
  Variants, Theme Elements, Colour Palette, Installation, Desktop
  Environments, and Troubleshooting.
- **`CONTRIBUTING.md`** — Added full contribution guidelines covering bug
  reports, feature requests, pull requests, code style, and adding new
  distribution support.
- **`TEMPLATE_USAGE.md`** — Updated to reflect the three-variant directory
  structure (`simplicity-dualtone/`, `simplicity-light/`, `simplicity-dark/`)
  and the renamed default theme.
- **`README.md`** — Updated with dual-tone variant information, corrected
  screenshots, wiki links, ASCII art, and repository URL.

#### GitHub Actions

- **`release.yml`** — Release workflow updated to use correct theme
  directories (`simplicity-dualtone`, `simplicity-dark`, `simplicity-light`),
  the Simplicity repository URL, and current installer options.

### 🔄 Changed

- **Default theme** — The dual-tone variant (`simplicity-dualtone/`) is now
  installed as the default theme (`Simplicity`). The original full-dark
  variant is installed as `Simplicity-Dark` using the `--dark` flag.
- **Installer** (`install.sh`) — Now copies `simplicity-dualtone/` to
  `~/.themes/Simplicity` by default. The `--dark` and `--light` flags install
  the additional variants as `Simplicity-Dark` and `Simplicity-Light`
  respectively.
- **`scripts/apply-theme.sh`** — Applies the `Simplicity` (dual-tone) theme
  by default; `--dark` and `--light` flags apply the corresponding variants.
- **Project name** — Renamed from Deskthem to Simplicity throughout the
  codebase, scripts, metadata, and documentation.

---

## [1.0.0] — 2026-04-24

### 🎉 Initial Release

Simplicity is a clean, modern dark theme suite for Linux desktop environments.
This first release ships full GTK 2 / 3 / 4 support, three window-manager themes,
auto-detecting per-distro installers, and a desktop-environment-aware apply script.

---

### ✨ Added

#### GTK Theme Files (`simplicity-dark/`)

- **GTK 2** (`gtk-2.0/gtkrc`) — Complete gtkrc stylesheet covering buttons,
  scrollbars, menus, tooltips, progress bars, and text entries using the
  Simplicity dark colour palette.
- **GTK 3** (`gtk-3.0/gtk.css`) — Full CSS stylesheet with `@define-color`
  variables for all palette roles, making colour customisation a one-line change.
- **GTK 3 settings** (`gtk-3.0/settings.ini`) — Preferences enabling dark
  mode, disabling overlay scrollbars, and setting icon/cursor theme hints.
- **GTK 4** (`gtk-4.0/gtk.css`) — Modern stylesheet targeting GTK 4 /
  libadwaita applications with the same variable-driven palette.
- **Theme metadata** (`index.theme`) — Desktop entry registering Simplicity as
  an X-GNOME-Metatheme with icon and cursor theme hints.

#### Window Manager Themes

- **Metacity** (`metacity-1/metacity-theme-3.xml`) — XML-based window-frame
  theme for GNOME Shell (Mutter) and MATE (Marco) window decorators. Provides
  titled titlebars with close / minimise / maximise button colouring aligned
  to the palette.
- **XFWM4** (`xfwm4/themerc`) — XFCE window manager `themerc` with matching
  colours for active and inactive title bars, borders, and buttons.
- **Openbox** (`openbox-3/themerc`) — Openbox window manager theme, also
  used by LXDE and LXQt. Includes full colour definitions for all window
  frame states.

#### Installer (`install.sh`)

- Auto-detects the running Linux distribution via `/etc/os-release`.
- Delegates to the appropriate per-distro installer to resolve dependencies.
- Copies theme files to `~/.themes/Simplicity-Dark/` (user install) or
  `/usr/share/themes/Simplicity-Dark/` (system install with `--system`).
- Calls `apply-theme.sh` to apply the theme immediately after install.
- Flags: `--system`, `--no-apply`, `--help`.

#### Uninstaller (`uninstall.sh`)

- Removes the theme directory from `~/.themes` and `/usr/share/themes`.
- Resets GNOME / MATE / XFCE / Cinnamon desktop settings via `gsettings`
  and `xfconf-query`.

#### Distro-Specific Installers (`distros/`)

| Distro family | Script | Package manager | Packages installed |
|---------------|--------|-----------------|--------------------|
| Ubuntu · Mint · Pop!\_OS · Elementary | `distros/ubuntu/install.sh` | apt | `gtk2-engines-murrine`, `gtk2-engines-pixbuf`, `gnome-themes-extra` |
| Debian · MX Linux · Kali · Parrot | `distros/debian/install.sh` | apt | Same as Ubuntu |
| Fedora · RHEL · CentOS · AlmaLinux | `distros/fedora/install.sh` | dnf | `gtk-murrine-engine`, `gtk2-engines` |
| Arch Linux · EndeavourOS · Garuda | `distros/arch/install.sh` | pacman / yay | `gtk-engine-murrine`, `gtk-engines` |
| Manjaro | `distros/manjaro/install.sh` | pamac / pacman | `gtk-engine-murrine`, `gtk-engines` |
| openSUSE Leap / Tumbleweed | `distros/opensuse/install.sh` | zypper | `gtk2-engine-murrine`, `gtk2-engines` |

#### Helper Scripts (`scripts/`)

- **`scripts/detect-distro.sh`** — Exports `DISTRO_ID`, `DISTRO_FAMILY`,
  `DISTRO_VERSION`, and `PKG_MANAGER` by reading `/etc/os-release`.
  Supports all major distribution families.
- **`scripts/apply-theme.sh`** — Detects `$XDG_CURRENT_DESKTOP` and applies
  the theme via the appropriate tooling (`gsettings`, `xfconf-query`, or a
  GTK settings file). Supports `--dry-run` mode to preview changes.
  Handles: GNOME, XFCE, MATE, Cinnamon, KDE Plasma, LXDE/LXQt, i3, Sway,
  Openbox, and a universal GTK-settings-file fallback.

#### GitHub Actions (`.github/workflows/release.yml`)

- Automated release workflow triggered on `v*.*.*` tags **and** via
  `workflow_dispatch` (manual trigger with version input).
- Builds `.tar.gz` and `.zip` release archives.
- Generates detailed release notes and attaches both archives to the
  GitHub Release.

#### Documentation

- **`README.md`** — Full end-user documentation with colour palette table,
  DE/distro support matrices, quick-start and manual installation guides,
  system-wide install instructions, uninstall instructions, repository
  structure reference, and contributing guide.
- **`TEMPLATE_USAGE.md`** — Step-by-step guide for using this repository as
  a starting point for a custom Linux theme: creating from the GitHub
  template, renaming the theme, customising the colour palette, updating
  metadata, adding/removing distro support, and testing.
- **`CHANGELOG.md`** — This file.

---

### 🎨 Colour Palette

| Role | Colour | Usage |
|------|--------|-------|
| Background | `#2d2d2d` | Main window and widget backgrounds |
| Dark Background | `#252525` | Sidebars, panels, header bars |
| Base (inputs) | `#1e1e1e` | Text entry, list view, tree view backgrounds |
| Foreground | `#e0e0e0` | Primary text colour |
| Accent / Selected | `#5294e2` | Selection highlight, focus rings, links |
| Error / Close btn | `#cf6679` | Error states, close window button |
| Warning / Min btn | `#e5a050` | Warning states, minimise window button |
| Success / Max btn | `#4caf50` | Success states, maximise window button |
| Borders | `#404040` | Widget and window borders |

---

### 🖥️ Supported Desktop Environments

| Desktop | GTK 2 | GTK 3 | GTK 4 | WM Theme |
|---------|:-----:|:-----:|:-----:|:--------:|
| GNOME | ✅ | ✅ | ✅ | Metacity |
| XFCE | ✅ | ✅ | — | XFWM4 |
| MATE | ✅ | ✅ | — | Metacity |
| Cinnamon | ✅ | ✅ | — | Metacity |
| KDE Plasma | ✅ | ✅ | ✅ | — |
| Openbox / LXDE / LXQt | ✅ | ✅ | — | Openbox |
| i3 / Sway | ✅ | ✅ | ✅ | — |

---

### 🐧 Supported Linux Distributions

| Distribution | Installer | Package Manager |
|-------------|-----------|-----------------|
| Ubuntu · Linux Mint · Pop!\_OS | `distros/ubuntu/` | apt |
| Debian · MX Linux · Kali Linux | `distros/debian/` | apt |
| Fedora · RHEL · CentOS · AlmaLinux | `distros/fedora/` | dnf |
| Arch Linux · EndeavourOS · Garuda | `distros/arch/` | pacman / yay |
| Manjaro | `distros/manjaro/` | pamac / pacman |
| openSUSE Leap / Tumbleweed | `distros/opensuse/` | zypper |
