# Using This Repository as a Template

> 🌐 **Translate this page:**
> [🇪🇸 Español](https://translate.google.com/translate?sl=en&tl=es&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇫🇷 Français](https://translate.google.com/translate?sl=en&tl=fr&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇩🇪 Deutsch](https://translate.google.com/translate?sl=en&tl=de&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇮🇹 Italiano](https://translate.google.com/translate?sl=en&tl=it&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇧🇷 Português](https://translate.google.com/translate?sl=en&tl=pt&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇷🇺 Русский](https://translate.google.com/translate?sl=en&tl=ru&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇨🇳 中文](https://translate.google.com/translate?sl=en&tl=zh-CN&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇯🇵 日本語](https://translate.google.com/translate?sl=en&tl=ja&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇰🇷 한국어](https://translate.google.com/translate?sl=en&tl=ko&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇸🇦 العربية](https://translate.google.com/translate?sl=en&tl=ar&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md) ·
> [🇮🇳 हिन्दी](https://translate.google.com/translate?sl=en&tl=hi&u=https://github.com/PhantomNimbi/Simplicity/blob/main/TEMPLATE_USAGE.md)

This repository is designed to be used as a starting point for creating your own Linux desktop theme suite. Follow the steps below to go from this template to a fully branded theme of your own.

## 1. Create Your Repository from This Template

1. Click the **"Use this template"** button at the top of this repository on GitHub.
2. Give your new repository a name (e.g. `my-linux-theme`).
3. Choose public or private visibility, then click **"Create repository from template"**.
4. Clone your new repository locally:

   ```bash
   git clone https://github.com/<your-username>/<your-repo-name>.git
   cd <your-repo-name>
   ```

---

## 2. Rename the Theme

The default theme name throughout this repository is **Simplicity**. Replace it with your own theme name everywhere it appears.

The quickest way is a global find-and-replace (case-sensitive):

```bash
# Replace all occurrences — adjust MY_THEME_NAME as needed
find . -not -path './.git/*' -type f \
  -exec sed -i 's/Simplicity/MY_THEME_NAME/g' {} +
```

After running the command, also rename the three theme variant directories:

```bash
# The default (dual-tone) variant has no suffix — it becomes the primary theme name.
mv simplicity-dualtone <my-theme-name-lowercase>
mv simplicity-light    <my-theme-name-lowercase>-light
mv simplicity-dark     <my-theme-name-lowercase>-dark
```

Then update the three path references inside `install.sh`:

```bash
# Lines that copy theme files — update source directory names
cp -r "${SCRIPT_DIR}/<my-theme-name-lowercase>/."       "${target_dir}/"
cp -r "${SCRIPT_DIR}/<my-theme-name-lowercase>-light/." "${light_target_dir}/"
cp -r "${SCRIPT_DIR}/<my-theme-name-lowercase>-dark/."  "${dark_target_dir}/"
```

### Files that reference the theme name

The following files all contain the theme name and will be updated by the command above:

| File | What it controls |
|------|-----------------|
| `simplicity-dualtone/index.theme` | Default variant metadata (name shown in desktop settings) |
| `simplicity-dualtone/gtk-2.0/gtkrc` | GTK 2 theme identifier (default variant) |
| `simplicity-dualtone/gtk-3.0/settings.ini` | GTK 3 settings (default variant) |
| `simplicity-dualtone/gtk-4.0/gtk.css` | GTK 4 theme header comment (default variant) |
| `simplicity-dualtone/metacity-1/metacity-theme-3.xml` | GNOME/MATE window decorator name |
| `simplicity-dualtone/xfwm4/themerc` | XFCE window manager theme name |
| `simplicity-dualtone/openbox-3/themerc` | Openbox window manager theme name |
| `simplicity-light/index.theme` | Light variant metadata |
| `simplicity-dark/index.theme` | Dark variant metadata |
| `install.sh` | Installer — copies files and applies the theme |
| `uninstall.sh` | Uninstaller — removes the theme |
| `scripts/apply-theme.sh` | Per-DE theme applicator |
| `distros/*/install.sh` | All distro-specific installers |
| `README.md` | End-user documentation |

---

## 3. Customise Your Colour Palette

All colours are defined as CSS variables at the top of the GTK stylesheet. The repository ships three pre-built variants — edit whichever best matches your intended palette.

**Default (Dual-Tone) — `simplicity-dualtone/gtk-3.0/gtk.css`**

The dual-tone variant keeps a dark chrome (header bar, sidebar, menus) over a light content area. It defines two colour groups:

```css
/* === Color Variables === */
/* Content area — light */
@define-color bg_color          #f5f5f5;   /* Main background */
@define-color fg_color          #2d2d2d;   /* Main foreground / text */
@define-color base_color        #ffffff;   /* Input / text-area background */
@define-color borders           #d0d0d0;   /* Widget borders */

/* Chrome area — dark */
@define-color header_bg         #252525;   /* Header bar background */
@define-color header_fg         #e0e0e0;   /* Header bar text */
@define-color sidebar_bg        #2a2a2a;   /* Sidebar background */

/* Shared */
@define-color selected_bg_color #5294e2;   /* Accent / selection colour */
@define-color warning_color     #e5a050;   /* Warnings */
@define-color error_color       #cf6679;   /* Errors / close button */
@define-color success_color     #4caf50;   /* Success / maximise button */
/* … and more — see the full file for all variables */
```

**Full Dark — `simplicity-dark/gtk-3.0/gtk.css`** — uses dark values for `bg_color`, `base_color`, and `fg_color` throughout, with no separate chrome group.

**Full Light — `simplicity-light/gtk-3.0/gtk.css`** — uses light values throughout; swap `bg_color` to your desired light background and `fg_color` to a dark text colour.

Apply the same colour changes to the matching files in each variant directory:

- `<variant>/gtk-2.0/gtkrc` — uses literal hex values (no CSS variables)
- `<variant>/metacity-1/metacity-theme-3.xml` — window frame colours
- `<variant>/xfwm4/themerc` — XFCE window manager colours
- `<variant>/openbox-3/themerc` — Openbox window manager colours

---

## 4. Update Theme Metadata

Edit `simplicity-dualtone/index.theme` (and the equivalent file in each variant) to reflect your theme's name and description:

```ini
[Desktop Entry]
Type=X-GNOME-Metatheme
Name=My Theme Name
Comment=A description of your theme

[X-GNOME-Metatheme]
GtkTheme=My Theme Name
MetacityTheme=My Theme Name
IconTheme=My-Icons          # optional — remove if you are not bundling icons
CursorTheme=My-Cursors      # optional — remove if you are not bundling cursors
ButtonLayout=close,minimize,maximize:
```

If you are not bundling a custom icon or cursor theme, remove those keys or point them to an existing system theme (e.g. `IconTheme=Papirus-Dark`).

---

## 5. Add or Remove Distribution Support

### Adding a new distribution

1. Create a new directory under `distros/<distro-name>/`.
2. Copy an existing `install.sh` from a similar distro as a starting point.
3. Update the package manager commands, package names, and any DE-specific steps.
4. Add a `README.md` with distro-specific notes.
5. Register the new distro in the `install_distro_specific` function of `install.sh`:

   ```bash
   <distro-id>)
       distro_installer="${SCRIPT_DIR}/distros/<distro-name>/install.sh"
       ;;
   ```

6. Add detection logic in `scripts/detect-distro.sh` if the distro is not already detected.

### Removing an unsupported distribution

1. Delete the corresponding directory under `distros/`.
2. Remove its `case` entry from `install.sh` and `scripts/detect-distro.sh`.

---

## 6. Update the README

Replace the content of `README.md` with documentation for your own theme:

- Update the title, banner text, and feature list.
- Update the **Colour Palette** table with your colours.
- Update the **Supported Desktop Environments** and **Supported Linux Distributions** tables.
- Update the clone URL in **Quick Start** to your repository URL.
- Update the **Repository Structure** tree to match any renamed directories.

If you are keeping `CONTRIBUTING.md`, update any repository-specific links (issue tracker URL, project name) to point at your own repository.

---

## 7. Test Your Theme

Before publishing, test the installation end-to-end on at least one supported distribution:

```bash
chmod +x install.sh
./install.sh --no-apply   # install files only, skip applying
```

Check that the theme directory was created correctly:

```bash
ls ~/.themes/<your-theme-name>/
```

Then apply and inspect the result:

```bash
./scripts/apply-theme.sh --dry-run   # preview commands without making changes
./scripts/apply-theme.sh             # apply to current session
```

---

## Repository Structure Reference

```
<your-repo>/
├── install.sh                  # Main installer (auto-detects distro)
├── uninstall.sh                # Uninstaller
├── README.md                   # End-user documentation (update this)
├── CHANGELOG.md                # Version history
├── CONTRIBUTING.md             # Contribution guidelines (update or remove)
├── TEMPLATE_USAGE.md           # This file (remove or keep for contributors)
│
├── <theme-name>/               # Default (dual-tone) variant (rename from simplicity-dualtone/)
│   ├── index.theme             # Theme metadata
│   ├── gtk-2.0/gtkrc           # GTK 2 theme
│   ├── gtk-3.0/gtk.css         # GTK 3 stylesheet  ← main colour file
│   ├── gtk-3.0/settings.ini    # GTK 3 settings
│   ├── gtk-4.0/gtk.css         # GTK 4 stylesheet
│   ├── metacity-1/             # GNOME/MATE window decorator
│   ├── xfwm4/                  # XFCE window manager
│   └── openbox-3/              # Openbox window manager
│
├── <theme-name>-light/         # Light variant (rename from simplicity-light/)
│   └── … (same layout as above)
│
├── <theme-name>-dark/          # Dark variant (rename from simplicity-dark/)
│   └── … (same layout as above)
│
├── distros/                    # Distribution-specific installers
│   ├── ubuntu/
│   ├── debian/
│   ├── fedora/
│   ├── arch/
│   ├── opensuse/
│   └── manjaro/
│
├── screenshots/                # Preview images for README
│
├── wiki/                       # Extended documentation
│
└── scripts/
    ├── detect-distro.sh        # Distro detection (extend for new distros)
    └── apply-theme.sh          # DE-aware theme applicator
```
