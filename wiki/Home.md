# Simplicity — Linux Desktop Theme Suite Wiki

> 🌐 **Translate this page:**
> [🇪🇸 Español](https://translate.google.com/translate?sl=en&tl=es&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇫🇷 Français](https://translate.google.com/translate?sl=en&tl=fr&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇩🇪 Deutsch](https://translate.google.com/translate?sl=en&tl=de&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇮🇹 Italiano](https://translate.google.com/translate?sl=en&tl=it&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇧🇷 Português](https://translate.google.com/translate?sl=en&tl=pt&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇷🇺 Русский](https://translate.google.com/translate?sl=en&tl=ru&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇨🇳 中文](https://translate.google.com/translate?sl=en&tl=zh-CN&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇯🇵 日本語](https://translate.google.com/translate?sl=en&tl=ja&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇰🇷 한국어](https://translate.google.com/translate?sl=en&tl=ko&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇸🇦 العربية](https://translate.google.com/translate?sl=en&tl=ar&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md) ·
> [🇮🇳 हिन्दी](https://translate.google.com/translate?sl=en&tl=hi&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md)

Welcome to the official wiki for **Simplicity**, a clean, modern GTK theme suite for Linux desktop environments.

![Simplicity preview](../screenshots/preview.png)

---

## Contents

| Page | Description |
|------|-------------|
| [Theme Variants](Theme-Variants.md) | Overview of all three theme variants with screenshots |
| [Theme Elements](Theme-Elements.md) | Breakdown of every UI component and how it's styled |
| [Colour Palette](Colour-Palette.md) | Complete colour reference for every variant |
| [Installation](Installation.md) | Step-by-step installation guide for every distro and DE |
| [Desktop Environments](Desktop-Environments.md) | Per-DE configuration and manual application instructions |
| [Troubleshooting](Troubleshooting.md) | Common problems and how to fix them |

---

## Quick Overview

**Simplicity** ships three ready-to-use theme variants:

| Variant | Theme Name | Style |
|---------|-----------|-------|
| **Dual-Tone** (default) | `Simplicity` | Dark chrome (header/sidebar/menus) + light content area |
| **Dark** | `Simplicity-Dark` | Fully dark — every surface uses the dark palette |
| **Light** | `Simplicity-Light` | Fully light — every surface uses the light palette |

Each variant provides complete coverage across:
- **GTK 2** — legacy applications
- **GTK 3** — most modern GTK apps
- **GTK 4 / libadwaita** — GNOME 40+ applications
- **GNOME Shell** — top panel, Activities overview, Quick Settings, notifications, and more
- **Metacity** — GNOME Shell (Mutter) and MATE (Marco) window decorator
- **XFWM4** — XFCE window manager
- **Openbox** — also used by LXDE and LXQt

---

## Supported Desktop Environments

| Desktop | GTK 2 | GTK 3 | GTK 4 | WM Theme | Shell Theme |
|---------|:-----:|:-----:|:-----:|:--------:|:-----------:|
| GNOME | ✅ | ✅ | ✅ | Metacity | ✅ |
| XFCE | ✅ | ✅ | — | XFWM4 | — |
| MATE | ✅ | ✅ | — | Metacity | — |
| Cinnamon | ✅ | ✅ | — | Metacity | — |
| KDE Plasma | ✅ | ✅ | ✅ | — | — |
| Openbox / LXDE / LXQt | ✅ | ✅ | — | Openbox | — |
| i3 / Sway | ✅ | ✅ | ✅ | — | — |

---

## Supported Linux Distributions

| Distribution | Package Manager |
|-------------|-----------------|
| Ubuntu · Linux Mint · Pop!\_OS | apt |
| Debian · MX Linux · Kali Linux | apt |
| Fedora · RHEL · CentOS · AlmaLinux | dnf |
| Arch Linux · EndeavourOS · Garuda | pacman / yay |
| Manjaro | pamac / pacman |
| openSUSE Leap / Tumbleweed | zypper |

---

## Quick Start

```bash
git clone https://github.com/PhantomNimbi/Simplicity.git
cd Simplicity
chmod +x install.sh
./install.sh
```

See the [Installation](Installation.md) page for the full guide including manual installation, system-wide installation, and per-variant options.
