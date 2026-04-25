# Troubleshooting

> 🌐 **Translate this page:**
> [🇪🇸 Español](https://translate.google.com/translate?sl=en&tl=es&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇫🇷 Français](https://translate.google.com/translate?sl=en&tl=fr&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇩🇪 Deutsch](https://translate.google.com/translate?sl=en&tl=de&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇮🇹 Italiano](https://translate.google.com/translate?sl=en&tl=it&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇧🇷 Português](https://translate.google.com/translate?sl=en&tl=pt&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇷🇺 Русский](https://translate.google.com/translate?sl=en&tl=ru&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇨🇳 中文](https://translate.google.com/translate?sl=en&tl=zh-CN&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇯🇵 日本語](https://translate.google.com/translate?sl=en&tl=ja&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇰🇷 한국어](https://translate.google.com/translate?sl=en&tl=ko&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇸🇦 العربية](https://translate.google.com/translate?sl=en&tl=ar&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md) ·
> [🇮🇳 हिन्दी](https://translate.google.com/translate?sl=en&tl=hi&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Troubleshooting.md)

This page covers the most common issues encountered when installing or using Simplicity, along with step-by-step resolutions.

---

## Theme Not Appearing in the Theme Picker

**Symptom:** Simplicity does not appear in GNOME Tweaks, XFCE Appearance Settings, or other theme selectors.

**Causes and fixes:**

1. **Theme files are in the wrong directory.**
   Confirm the theme directory exists and is structured correctly:
   ```bash
   ls ~/.themes/Simplicity/
   # Expected: cinnamon  gnome-shell  gtk-2.0  gtk-3.0  gtk-4.0  index.theme  metacity-1  openbox-3  xfwm4
   ```
   If the directory is missing or named differently, re-run the installer or manually copy the files:
   ```bash
   cp -r Simplicity/simplicity-dualtone ~/.themes/Simplicity
   ```

2. **Missing `index.theme`.**
   The file `~/.themes/Simplicity/index.theme` must exist for desktop environments to register the theme. Verify:
   ```bash
   cat ~/.themes/Simplicity/index.theme
   ```
   It should contain a `[Desktop Entry]` block with `Name=Simplicity`.

3. **Themes directory is not in the search path.**
   Make sure `~/.themes` is the themes directory being scanned. Some systems use `~/.local/share/themes` instead. You can install to both:
   ```bash
   mkdir -p ~/.local/share/themes
   cp -r ~/.themes/Simplicity ~/.local/share/themes/Simplicity
   ```

---

## GTK 2 Applications Look Unstyled

**Symptom:** Older GTK 2 applications (e.g. GIMP 2, gedit 2, Audacity) do not adopt the Simplicity style and appear with a default or fallback theme.

**Cause:** The Murrine GTK 2 engine is missing.

**Fix:**

```bash
# Ubuntu / Debian / Mint
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf

# Fedora
sudo dnf install gtk-murrine-engine gtk2-engines

# Arch Linux
sudo pacman -S gtk-engine-murrine gtk-engines

# openSUSE
sudo zypper install gtk2-engine-murrine gtk2-engines
```

After installing, restart your GTK 2 applications.

---

## GNOME Shell Theme Not Applying

**Symptom:** The GNOME panel, Activities overview, Quick Settings, or notifications do not adopt the Simplicity style; they continue to show the default Adwaita shell look.

**Causes and fixes:**

1. **The user-theme GNOME Shell extension is not installed.**
   Applying a custom shell theme in GNOME requires the `user-themes` extension:
   ```bash
   # Check whether it is installed
   gnome-extensions list | grep user-theme

   # Install via your package manager — example on Ubuntu/Debian
   sudo apt install gnome-shell-extension-user-theme
   ```
   Alternatively, install it from [extensions.gnome.org/extension/19/user-themes/](https://extensions.gnome.org/extension/19/user-themes/).

2. **The extension is installed but not enabled.**
   ```bash
   gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
   ```
   Then re-run the apply script to set the shell theme:
   ```bash
   ./scripts/apply-theme.sh
   ```

3. **Set the shell theme manually** (if the apply script is unavailable):
   ```bash
   gsettings set org.gnome.shell.extensions.user-theme name "Simplicity"
   ```

4. **GNOME Shell version mismatch.**
   If GNOME Shell displays a warning that the theme is incompatible, the theme may need a version bump in `gnome-shell/gnome-shell.css`. The `@import` block at the top of the file contains a version string — update it to match the output of:
   ```bash
   gnome-shell --version
   ```

---

## Cinnamon Shell Theme Not Applying

**Symptom:** The Cinnamon panel, applets, menus, notifications, or OSD overlays still show the default Cinnamon appearance after installation.

**Causes and fixes:**

1. **Shell theme not set.**
   The Cinnamon shell theme (`cinnamon/cinnamon.css`) is separate from the GTK theme. Apply it with:
   ```bash
   gsettings set org.cinnamon.theme name "Simplicity"
   ```
   The `apply-theme.sh` script does this automatically on Cinnamon desktops. Re-run it to ensure all three settings are written:
   ```bash
   ./scripts/apply-theme.sh
   # This sets:
   #   org.cinnamon.desktop.interface gtk-theme
   #   org.cinnamon.desktop.wm.preferences theme
   #   org.cinnamon.theme name
   ```

2. **Cinnamon System Settings — applying via the GUI.**
   Open **System Settings → Themes** and select **Simplicity** under the *Desktop* (shell theme) selector as well as the *Controls* (GTK) and *Window borders* selectors.

3. **Theme not detected by Cinnamon System Settings.**
   Confirm the `CinnamonTheme` key is present in `~/.themes/Simplicity/index.theme`:
   ```bash
   grep CinnamonTheme ~/.themes/Simplicity/index.theme
   # Expected output:  CinnamonTheme=Simplicity
   ```
   If it is missing, the `cinnamon.css` file may not have been installed. Re-run the installer.

4. **Changes visible only after a shell restart.**
   After applying the shell theme, restart the Cinnamon shell without logging out:
   ```bash
   cinnamon --replace &
   ```

---

## GTK 4 / libadwaita Applications Ignore the Theme

**Symptom:** GNOME 40+ applications (Files, Settings, Builder, etc.) still show the default Adwaita styling.

**Explanation:** From GNOME 42 onwards, libadwaita applications read the system `color-scheme` preference and do not respect arbitrary GTK 3 themes for their internal palette. The Simplicity GTK 4 stylesheet provides *overrides* for header bars, sidebars, and popovers, but the internal widget palette of libadwaita apps is controlled by the `color-scheme` setting.

**Fixes:**

1. Set the color-scheme preference:
   ```bash
   # For Simplicity or Simplicity-Light (light content area)
   gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

   # For Simplicity-Dark
   gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
   ```

2. The `apply-theme.sh` script sets this automatically. Run it again:
   ```bash
   ./scripts/apply-theme.sh        # dual-tone (prefer-light)
   ./scripts/apply-theme.sh --dark # dark (prefer-dark)
   ```

3. For full libadwaita recolouring (accent colour etc.), you can also use
   `~/.config/gtk-4.0/gtk.css` overrides, which the theme already provides.

---

## Window Buttons or Decorations Look Wrong

**Symptom:** The window title bar or close/minimise/maximise buttons use the default theme or look mismatched.

**Causes and fixes:**

1. **Wrong window manager theme applied.**
   - GNOME / MATE: `gsettings set org.gnome.desktop.wm.preferences theme "Simplicity"`
   - XFCE: `xfconf-query -c xfwm4 -p /general/theme -s "Simplicity"`

2. **Client-side decorations (CSD) vs. server-side decorations (SSD).**
   On Wayland or with GNOME Shell, most windows use CSD (decorations are drawn by GTK inside the window). The Simplicity header bar styles apply to CSD. For SSD (decoration drawn by the WM), the Metacity/XFWM4/Openbox theme is used.

3. **GNOME Shell extension conflict.**
   If you have a window decoration extension active, it may override the theme. Disable conflicting extensions via GNOME Extensions or:
   ```bash
   gnome-extensions disable <extension-id>
   ```

---

## Theme Reverts After Reboot

**Symptom:** The theme was applied successfully but resets to the default after logging out and back in.

**Causes and fixes:**

1. **GNOME:** Settings were written but not persisted. Confirm with:
   ```bash
   gsettings get org.gnome.desktop.interface gtk-theme
   ```
   If it shows the correct value but reverts, another startup script or session restore may be overriding it. Check `~/.profile`, `~/.bashrc`, and autostart files in `~/.config/autostart/`.

2. **XFCE:** The xfconf settings database may not have been saved. Run:
   ```bash
   xfconf-query -c xsettings -p /Net/ThemeName -s "Simplicity"
   xfconf-query -c xfwm4 -p /general/theme -s "Simplicity"
   ```

3. **Tiling WMs (i3, Sway, Openbox):** The GTK settings file may not be present. Create it:
   ```bash
   mkdir -p ~/.config/gtk-3.0
   cat > ~/.config/gtk-3.0/settings.ini << 'EOF'
   [Settings]
   gtk-theme-name=Simplicity
   gtk-application-prefer-dark-theme=0
   EOF
   ```

---

## Colours Look Wrong or Washed Out

**Symptom:** The theme colours appear desaturated, overly dark, or incorrect.

**Causes and fixes:**

1. **Wrong variant installed vs. applied.**
   Check which theme is currently active:
   ```bash
   gsettings get org.gnome.desktop.interface gtk-theme
   ```
   Ensure it matches a correctly installed directory in `~/.themes/` or `/usr/share/themes/`.

2. **The GTK dark-mode flag is inverted.**
   - For `Simplicity` and `Simplicity-Light`, `gtk-application-prefer-dark-theme` must be `0`.
   - For `Simplicity-Dark`, it should be `1`.
   Check:
   ```bash
   cat ~/.config/gtk-3.0/settings.ini
   ```

3. **Display colour profile mismatch.**
   This is unrelated to the theme. Check your monitor's ICC profile settings in your display/colour management settings.

---

## apply-theme.sh Reports "Theme Not Installed"

**Symptom:**
```
[ERROR] Theme 'Simplicity' is not installed.
[ERROR] Run install.sh first to install the theme.
```

**Fix:**
Run the installer first:
```bash
./install.sh
```
Or manually copy the theme files:
```bash
cp -r simplicity-dualtone ~/.themes/Simplicity
```

---

## Scrollbars Are Not Visible

**Symptom:** Scrollbars disappear or are extremely thin and hard to click.

**Explanation:** The Simplicity GTK 3 theme uses overlay scrollbars (a GNOME convention) that fade in on hover. This is controlled by the GTK 3 settings.

**Fix:**
To use traditional always-visible scrollbars, add to `~/.config/gtk-3.0/settings.ini`:

```ini
[Settings]
gtk-overlay-scrolling=false
```

---

## Installer Fails with "Unknown Distribution"

**Symptom:**
```
[WARN]  Distribution 'your-distro' not specifically supported.
[INFO]  Attempting generic installation...
```

**Explanation:** The installer did not recognise your distribution ID and skipped the dependency installation step. The theme files were still copied.

**Fix:**
1. Manually install the GTK engine packages for your distribution (see [Installation — Manual Installation](Installation.md#method-3--manual-installation)).
2. Then apply the theme manually (see [Installation — Applying the Theme Manually](Installation.md#method-4--applying-the-theme-manually)).

If you would like your distribution to be supported officially, see the [Contributing section in the README](../README.md#contributing).

---

## Useful Diagnostic Commands

```bash
# Show currently active GTK theme (GNOME)
gsettings get org.gnome.desktop.interface gtk-theme

# Show currently active WM theme (GNOME)
gsettings get org.gnome.desktop.wm.preferences theme

# Show currently active GNOME Shell theme
gsettings get org.gnome.shell.extensions.user-theme name

# Show currently active Cinnamon shell theme
gsettings get org.cinnamon.theme name

# Show detected desktop environment
echo "$XDG_CURRENT_DESKTOP"

# List all installed themes
ls ~/.themes/ /usr/share/themes/ 2>/dev/null

# Verify theme file structure
ls -1 ~/.themes/Simplicity/

# Test apply-theme script without making changes
./scripts/apply-theme.sh --dry-run

# Detect your distribution info
bash scripts/detect-distro.sh
```
