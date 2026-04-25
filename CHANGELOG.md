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

## [1.11.0] — 2026-04-25

### 🐛 Fixed

#### Uninstaller — Dangling GTK4 Symlink

- **`uninstall.sh`** — Extended `remove_gtk_settings()` to also remove the
  `~/.config/gtk-4.0/gtk.css` symlink when it points into a Simplicity theme
  directory. The `apply_gtk4_libadwaita` helper in `scripts/apply-theme.sh`
  (added in v1.10.x) creates this symlink so that libadwaita applications
  (Nautilus, GNOME Settings, etc.) pick up the theme colours. Previously,
  running `uninstall.sh` removed the theme directories but left the symlink in
  place, causing it to become a dangling reference and potentially breaking
  GTK4 application styling until the symlink was removed manually. The fix
  checks whether the symlink target contains `Simplicity` before removing it,
  so user-created `gtk.css` overrides that are unrelated to this theme are
  never touched.

#### Documentation

- **`wiki/Installation.md`** — Added
  `rm -f ~/.config/gtk-4.0/gtk.css` to the **Manual Uninstall** section.
  The command was missing from the manual steps even though `uninstall.sh`
  now handles it automatically.
- **`CHANGELOG.md`** — This entry.

---

## [1.10.0] — 2026-04-25

### 🐛 Fixed

#### Installer — Devuan Routing

- **`install.sh`** — Added `devuan` to the `install_distro_specific` Debian
  case. Devuan was already detected as a Debian-family distribution by
  `scripts/detect-distro.sh` and was listed in the **Supported Linux
  Distributions** table in `README.md`, but the routing in the installer did
  not include it, so Devuan users received a "not specifically supported"
  warning instead of running the Debian dependency installer.

#### Documentation

- **`distros/debian/install.sh`** — Updated the header comment to include
  Devuan in the supported-distros list.
- **`wiki/Installation.md`** — Added the missing
  `rm -rf ~/.themes/Simplicity-Dracula` line to the **Manual Uninstall**
  section. The Dracula variant directory was already removed by `uninstall.sh`
  and listed in the manual uninstall commands in `README.md`, but was omitted
  from the wiki copy of those commands.
- **`CHANGELOG.md`** — This entry.

---

## [1.9.0] — 2026-04-25

### 🗑️ Removed

#### Cursor Pack References (Simplicity-Cursors)

- **`simplicity-dark/index.theme`**, **`simplicity-dracula/index.theme`**,
  **`simplicity-dualtone/index.theme`**, **`simplicity-light/index.theme`** —
  Removed `CursorTheme=Simplicity-Cursors` key from the `[X-GNOME-Metatheme]`
  section of all four variant metadata files.
- **`simplicity-dark/gtk-3.0/settings.ini`**,
  **`simplicity-dracula/gtk-3.0/settings.ini`**,
  **`simplicity-dualtone/gtk-3.0/settings.ini`**,
  **`simplicity-light/gtk-3.0/settings.ini`** — Removed
  `gtk-cursor-theme-name=Simplicity-Cursors` and
  `gtk-cursor-theme-size=24` from all four GTK 3 settings files.
- **`scripts/apply-theme.sh`** — Removed `gtk-cursor-theme-name=Simplicity-Cursors`
  from the GTK settings-file fallback block written during theme application.

#### Documentation

- **`TEMPLATE_USAGE.md`** — Removed `CursorTheme=My-Cursors` from the
  `[X-GNOME-Metatheme]` example block. Updated guidance note to reference only
  the icon theme key (no longer mentions cursor theme bundling).
- **`CHANGELOG.md`** — This entry.

---

## [1.8.0] — 2026-04-25

### 🗑️ Removed

#### Icon Pack (Simplicity-Icons)

- **`simplicity-icons/`** — Entire Windows 11-inspired icon theme directory
  removed from the repository. This includes the `index.theme` metadata file
  and all scalable SVG icons previously in
  `scalable/{apps,places,actions,status,mimetypes}/`.
- **`install.sh`** — `install_icon_theme()` function removed. Icon theme
  installation (including `gtk-update-icon-cache` invocation) is no longer
  performed by the installer.
- **`update.sh`** — `update_icon_theme()` function removed. Icon cache
  regeneration is no longer triggered on update.
- **`uninstall.sh`** — `remove_icon_theme()` function removed. The uninstaller
  no longer deletes `~/.local/share/icons/Simplicity-Icons/` (or the system
  path). `reset_gsettings()` no longer resets
  `org.gnome.desktop.interface icon-theme`.
- **`scripts/apply-theme.sh`** — `apply_icon_theme()` helper removed. Setting
  `org.gnome.desktop.interface icon-theme` (GNOME/MATE/Cinnamon) and
  `/Net/IconThemeName` (XFCE) is no longer performed. The GTK settings-file
  fallback no longer writes `gtk-icon-theme-name`.
- **`simplicity-dark/index.theme`**, **`simplicity-dracula/index.theme`**,
  **`simplicity-dualtone/index.theme`**, **`simplicity-light/index.theme`** —
  Removed `IconTheme=Simplicity-Icons` key from the `[X-GNOME-Metatheme]`
  section of all four variant metadata files.

#### Documentation

- **`README.md`** — Icon Theme bullet removed from the Features section.
  `simplicity-icons/` directory tree removed from the Repository Structure
  section. Manual uninstall commands for
  `~/.local/share/icons/Simplicity-Icons` removed.
- **`CONTRIBUTING.md`** — `simplicity-icons/` subtree removed from the
  Repository Structure tree. `cinnamon/cinnamon.css` guideline no longer
  references icon-theme files.
- **`TEMPLATE_USAGE.md`** — `simplicity-icons/index.theme` rows removed from
  the Files-that-reference-the-theme-name table. `simplicity-icons/` removed
  from the Repository Structure Reference.
- **`wiki/Home.md`** — Icon Theme row removed from the Quick Overview coverage
  list.
- **`wiki/Installation.md`** — Icon theme installation path and
  `gtk-update-icon-cache` notes removed from prerequisites and manual
  installation sections.
- **`wiki/Theme-Elements.md`** — **Icon Theme** section removed.
- **`CHANGELOG.md`** — This entry.

---

## [1.7.0] — 2026-04-25

### 📝 Docs

- **`README.md`** — Added **Cinnamon Shell** as a dedicated bullet in the Features
  section, covering panels, panel applets, popup menus, notifications, OSD
  overlays, and calendar. Added **Dracula Theme** bullet to the Features section
  (`Simplicity-Dracula` — deep navy background with purple accent).
- **`CONTRIBUTING.md`** — Repository Structure tree updated to reflect the full
  current layout: `update.sh`, `simplicity-dracula/`, `simplicity-icons/`
  (with full subdirectory breakdown), `screenshots/`, `wiki/`, and top-level
  documentation files added. Shell Scripts guideline updated to reference
  `update.sh` alongside `install.sh` and `apply-theme.sh` for flag documentation.
- **`TEMPLATE_USAGE.md`** — `update.sh` added to the Files-that-reference-the-
  theme-name table. `simplicity-icons/index.theme` added to the same table.
  Repository Structure Reference updated to include `update.sh` and the full
  `simplicity-icons/` directory tree.
- **`CHANGELOG.md`** — This entry.

---

## [1.6.0] — 2026-04-25

### ✨ Added

#### Cinnamon Shell Theme

- **`cinnamon/cinnamon.css`** added to all four theme variants
  (`simplicity-dualtone/`, `simplicity-dark/`, `simplicity-light/`,
  `simplicity-dracula/`). Each stylesheet themes the full Cinnamon shell
  chrome — top/bottom/side panels, panel applets and the window list,
  popup and context menus, tooltips, notifications, OSD (volume / brightness)
  overlays, modal dialogs, and the date/time calendar widget — using the
  respective variant's colour palette.
  - **Dual-Tone** — dark panel and chrome (`#252525`) with blue accent (`#5294e2`)
  - **Dark** — full dark chrome (`#1e1e1e`/`#2d2d2d`) with blue accent
  - **Light** — light panel and chrome (`#ebebeb`/`#f5f5f5`) with blue accent
  - **Dracula** — deep-navy chrome (`#21222c`/`#191a21`) with purple accent (`#bd93f9`)
- **`CinnamonTheme`** key added to all four `index.theme` files, registering
  the Cinnamon shell theme in the `[X-GNOME-Metatheme]` section so Cinnamon
  System Settings can discover and apply the shell theme automatically.

#### Documentation

- **`README.md`** — Repository structure updated to show `cinnamon/` directory
  for the dual-tone variant. Supported Desktop Environments table updated with
  a **Shell Theme** ✅ for Cinnamon.
- **`CONTRIBUTING.md`** — Variant directory layout tree updated to include
  `cinnamon/cinnamon.css`. The "Apply the same colour change" guideline now
  lists `cinnamon/cinnamon.css` alongside the other per-variant files.
- **`TEMPLATE_USAGE.md`** — Files-that-reference-the-theme-name table updated
  to include `cinnamon/cinnamon.css` entries for all four variants. Repository
  Structure Reference updated to show `cinnamon/cinnamon.css` in the variant
  directory layout.
- **`wiki/Home.md`** — Cinnamon shell added to the Quick Overview coverage list.
  Cinnamon row updated in the Supported Desktop Environments table (Shell Theme ✅).
- **`wiki/Desktop-Environments.md`** — Cinnamon section updated with Shell Theme
  metadata line and GUI method updated to include the Desktop (shell theme) step.
- **`wiki/Installation.md`** — Expected `ls` output updated to include the
  `cinnamon` directory.
- **`wiki/Theme-Elements.md`** — New **Cinnamon Shell** section added, covering
  panel, popup menus, notifications, OSD, modal dialogs, and calendar widget with
  colour references per variant.
- **`CHANGELOG.md`** — This entry.

---

## [1.5.0] — 2026-04-25

### ✨ Added

#### Simplicity-Icons — Windows 11-Inspired Icon Theme

- **`simplicity-icons/`** — New Windows 11-inspired icon theme (`Simplicity-Icons`)
  delivering scalable SVG icons across five icon contexts. All icons follow the
  Fluent Design language: rounded shapes, vibrant gradients, and a consistent
  visual weight.

  - **`index.theme`** — Freedesktop-compliant icon theme metadata. Registers five
    scalable directories (`apps`, `places`, `actions`, `status`, `mimetypes`) and
    inherits from `hicolor` so that any icon not yet provided by the theme falls
    back gracefully.

  - **`scalable/places/`** — Nine place icons:
    `folder`, `folder-open`, `folder-home`, `folder-downloads`,
    `folder-documents`, `folder-pictures`, `folder-music`,
    `user-trash`, `user-trash-full`.
    Folders use a warm golden gradient (`#FFD04A` → `#FFA000`) with a
    distinctive tab and a themed badge indicating the folder type.

  - **`scalable/apps/`** — Six application icons:
    `utilities-terminal`, `text-editor`, `system-file-manager`,
    `preferences-system`, `web-browser`, `system-software-install`.
    Each uses a rounded-rectangle app background (Windows 11 tile style) with
    a white icon inside.

  - **`scalable/actions/`** — Twelve action/toolbar icons:
    `document-new`, `document-open`, `document-save`,
    `edit-copy`, `edit-paste`, `edit-cut`, `edit-delete`,
    `edit-undo`, `edit-redo`, `go-home`, `view-refresh`, `list-add`.
    Rendered in the Simplicity accent blue (`#5294e2`) on a transparent
    background for clean toolbar integration.

  - **`scalable/status/`** — Five status icons:
    `dialog-information` (blue), `dialog-warning` (yellow),
    `dialog-error` (red), `dialog-question` (blue), `network-wireless`.
    Colour-coded with Windows 11 system colours (`#0078D4`, `#FFB900`,
    `#D13438`).

  - **`scalable/mimetypes/`** — Five file-type icons:
    `text-x-generic`, `image-x-generic`, `audio-x-generic`,
    `video-x-generic`, `application-x-executable`.
    Each uses a document base shape with a colour-coded top bar and a
    representative content badge.

#### Installer / Updater / Uninstaller / Apply-Theme

- **`install.sh`** — `install_icon_theme()` function added. Installs
  `simplicity-icons/` to `~/.local/share/icons/Simplicity-Icons/` (user
  install) or `/usr/share/icons/Simplicity-Icons/` (system install).
  Runs `gtk-update-icon-cache` automatically when available.
- **`update.sh`** — `update_icon_theme()` function added. Refreshes the
  installed icon theme from the repository, then regenerates the icon cache.
- **`uninstall.sh`** — `remove_icon_theme()` function added. Removes
  `~/.local/share/icons/Simplicity-Icons/` (and the system path when
  `--system` is passed). `reset_gsettings()` now also resets
  `org.gnome.desktop.interface icon-theme`.
- **`scripts/apply-theme.sh`** — `apply_icon_theme()` helper added. Sets
  `org.gnome.desktop.interface icon-theme` via `gsettings` (GNOME, MATE,
  Cinnamon) or `/Net/IconThemeName` via `xfconf-query` (XFCE). Called
  automatically from each DE-specific apply function. GTK settings-file
  fallback also merges `gtk-icon-theme-name` into existing `settings.ini`
  files.

#### Documentation

- **`README.md`** — Icon Theme bullet added to the Features section.
  `simplicity-icons/` with full directory tree added to the Repository
  Structure section. Manual uninstall commands updated to include
  `~/.local/share/icons/Simplicity-Icons` and `icon-theme` gsettings reset.
- **`wiki/Home.md`** — Icon Theme row added to the Quick Overview coverage list.
- **`wiki/Installation.md`** — Icon theme installation path and
  `gtk-update-icon-cache` note added to the prerequisites and manual
  installation sections.
- **`wiki/Theme-Elements.md`** — New **Icon Theme** section added, covering
  all five icon contexts with colour references and design language notes.
- **`CHANGELOG.md`** — This entry.

---

## [1.4.0] — 2026-04-25

### ✨ Added

#### Dracula Theme Variant

- **`simplicity-dracula/`** — New theme variant based on the
  [Dracula colour palette](https://draculatheme.com). A full dark theme using
  Dracula's signature deep-navy backgrounds with a purple accent colour.
  - **GTK 2** (`gtk-2.0/gtkrc`) — Complete Dracula-palette gtkrc stylesheet.
  - **GTK 3** (`gtk-3.0/gtk.css`) — Full CSS stylesheet with Dracula
    `@define-color` variables.
  - **GTK 3 settings** (`gtk-3.0/settings.ini`) — Sets
    `gtk-application-prefer-dark-theme=1`.
  - **GTK 4** (`gtk-4.0/gtk.css`) — Dracula-palette overrides for header bars,
    sidebars, and popovers.
  - **GNOME Shell** (`gnome-shell/gnome-shell.css`) — Full shell chrome theme
    with `#191a21` panel and `#bd93f9` accent.
  - **Metacity** (`metacity-1/metacity-theme-3.xml`) — Dracula-palette window
    decorator.
  - **XFWM4** (`xfwm4/themerc`) — XFCE window manager theme with `#21222c`
    active titlebar and `#bd93f9` frame accent.
  - **Openbox** (`openbox-3/themerc`) — Openbox window manager theme.
  - **Theme metadata** (`index.theme`) — Registers `Simplicity-Dracula` with
    `GnomeShellTheme` key so GNOME Tweaks can discover it automatically.

#### Installer / Updater / Apply-Theme

- **`install.sh`** — `--dracula` flag added to install `Simplicity-Dracula`
  alongside the default dual-tone variant.
- **`update.sh`** — `--dracula` flag added to update an existing
  `Simplicity-Dracula` installation.
- **`scripts/apply-theme.sh`** — `--dracula` flag added to apply the Dracula
  variant to the current desktop session.

#### Documentation

- **`README.md`** — Dracula variant added to the Theme Variants table.
  `--dracula` flag added to the Installer Options, Updater Options, and
  apply-theme examples. `simplicity-dracula/` added to the Repository Structure
  tree.
- **`wiki/Home.md`** — Dracula added to the Quick Overview table.
- **`wiki/Theme-Variants.md`** — Full Dracula section added with colour palette
  table and usage guidance.
- **`wiki/Colour-Palette.md`** — Dracula palette section added with all CSS
  variable definitions.
- **`wiki/Installation.md`** — `--dracula` flag added to the Installer
  Reference, Apply-Theme Script Reference, and variant installation examples.
- **`TEMPLATE_USAGE.md`** — Updated to reflect four available theme variants.
- **`CHANGELOG.md`** — This entry.

---

## [1.3.1] — 2026-04-25

### 📝 Docs

- **`CONTRIBUTING.md`** — Variant directory layout tree updated to include
  `gnome-shell/gnome-shell.css`. The "Apply the same colour change" guideline
  in the **Theme Files** section now lists `gnome-shell/gnome-shell.css`
  alongside the other per-variant files.
- **`TEMPLATE_USAGE.md`** — Files-that-reference-the-theme-name table updated
  to include `gnome-shell/gnome-shell.css` entries for all three variants
  (`simplicity-dualtone/`, `simplicity-light/`, `simplicity-dark/`). Repository
  Structure Reference updated to show `gnome-shell/gnome-shell.css` in the
  variant directory layout.
- **`README.md`** — GNOME Shell added as a dedicated bullet in the **Features**
  section, covering panel, Activities overview, Quick Settings, notifications,
  OSD, and lock screen.

---

## [1.3.0] — 2026-04-25

### ✨ Added

#### GNOME Shell Themes

- **`gnome-shell/gnome-shell.css`** added to all three theme variants
  (`simplicity-dualtone/`, `simplicity-dark/`, `simplicity-light/`).
  Each stylesheet themes the full GNOME Shell chrome — top panel, Activities
  overview, app grid, panel menus and popovers, Quick Settings (GNOME 43+),
  notifications, OSD overlays, dash dock, calendar, modal dialogs, lock screen,
  and tooltips — using the respective variant's colour palette.
  - **Dual-Tone** — dark panel and chrome (`#252525`) with blue accent (`#5294e2`)
  - **Dark** — full dark chrome (`#1e1e1e`/`#2d2d2d`) with blue accent
  - **Light** — light panel and chrome (`#ebebeb`/`#f5f5f5`) with blue accent
- **`GnomeShellTheme`** key added to all three `index.theme` files, registering
  the shell theme in the `[X-GNOME-Metatheme]` section so tools such as
  GNOME Tweaks can discover and apply the shell theme automatically.

#### Documentation

- **`README.md`** — Repository structure updated to show `gnome-shell/` directory
  for each variant. Supported Desktop Environments table updated with a
  **Shell Theme** column (✅ for GNOME).
- **`wiki/Theme-Elements.md`** — New **GNOME Shell** section added, covering
  every themed shell component with colour references per variant.

---

## [1.2.1] — 2026-04-25

### 🔄 Changed

- **All distro-specific installers** (`distros/*/install.sh`) — Updated default
  theme from `Simplicity-Dark` (full dark) to `Simplicity` (dual-tone) to match
  the v1.1.0 default. Source directory corrected from `simplicity-dark/` to
  `simplicity-dualtone/`, GNOME color-scheme updated from `prefer-dark` to
  `prefer-light`, and GTK settings source path updated accordingly.
- **All distro README files** (`distros/*/README.md`) — Manual installation
  instructions updated to reference `simplicity-dualtone/` → `~/.themes/Simplicity`
  and the correct `prefer-light` color-scheme and `gtk-application-prefer-dark-theme=0`
  settings for the dual-tone default variant.

---

## [1.2.0] — 2026-04-25

### ✨ Added

- **Ubuntu 26.04 LTS support** — `distros/ubuntu/install.sh` and
  `distros/ubuntu/README.md` updated to explicitly support Ubuntu 26.04 LTS
  (Noble Numbat successor). No installer logic changes required; existing
  apt-based dependency installation and GNOME/XFCE theme application are
  fully compatible with Ubuntu 26.04.

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

- **[GitHub Wiki](https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Home.md)** — Comprehensive wiki added with pages for Home, Theme
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
