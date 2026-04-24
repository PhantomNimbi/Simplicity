# Desktop Environments

This page provides desktop-environment-specific configuration details, manual application instructions, and notes on any DE-specific behaviour.

---

## GNOME

**WM theme:** Metacity (via Mutter)  
**GTK versions:** GTK 2, GTK 3, GTK 4 / libadwaita  
**Applied via:** `gsettings`

### Applying the theme

```bash
# Apply Simplicity (dual-tone)
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

# Apply Simplicity-Dark
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity-Dark"
gsettings set org.gnome.desktop.wm.preferences theme "Simplicity-Dark"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### GNOME Shell theme (optional)

The GNOME Shell (top bar, Activities overview, notification panel) uses a separate shell theme. To apply Simplicity as the shell theme you need the **User Themes** extension:

1. Install the extension:
   - From [extensions.gnome.org/extension/19/user-themes](https://extensions.gnome.org/extension/19/user-themes/)
   - Or: `sudo apt install gnome-shell-extension-user-theme` (Ubuntu/Debian)

2. Enable the extension and select the theme:
   ```bash
   gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
   gsettings set org.gnome.shell.extensions.user-theme name "Simplicity"
   ```

### GNOME Tweaks (GUI alternative)

If you prefer a GUI, install GNOME Tweaks:

```bash
# Ubuntu/Debian
sudo apt install gnome-tweaks

# Fedora
sudo dnf install gnome-tweaks

# Arch
sudo pacman -S gnome-tweaks
```

Then open **Tweaks → Appearance** and set:
- **Legacy Applications (GTK2/3)** → Simplicity
- **Window titlebars** → Simplicity
- **Shell** → Simplicity (requires User Themes extension)

### libadwaita applications (GNOME 42+)

GTK 4 applications using libadwaita respect the `color-scheme` setting. Setting `prefer-dark` activates the app's built-in dark palette; `prefer-light` uses light. The Simplicity GTK 4 stylesheet overrides the header bar colours and window chrome to match the theme.

---

## XFCE

**WM theme:** XFWM4  
**GTK versions:** GTK 2, GTK 3  
**Applied via:** `xfconf-query`

### Applying the theme

```bash
# Apply GTK theme
xfconf-query -c xsettings -p /Net/ThemeName -s "Simplicity"

# Apply window manager theme
xfconf-query -c xfwm4 -p /general/theme -s "Simplicity"
```

### GUI method

1. **Settings → Appearance** → Widget tab → select **Simplicity**
2. **Settings → Window Manager** → Style tab → select **Simplicity**

### Creating the xfconf channels (if missing)

If the xfconf channels don't exist yet (fresh installation):

```bash
xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "Simplicity"
xfconf-query -c xfwm4 -p /general/theme -n -t string -s "Simplicity"
```

---

## MATE

**WM theme:** Marco (Metacity-compatible)  
**GTK versions:** GTK 2, GTK 3  
**Applied via:** `gsettings` (MATE schema)

### Applying the theme

```bash
gsettings set org.mate.interface gtk-theme "Simplicity"
gsettings set org.mate.Marco.general theme "Simplicity"
```

### GUI method

**System → Preferences → Appearance** → select **Simplicity** in the Themes tab.

---

## Cinnamon

**WM theme:** Muffin (Metacity-compatible)  
**GTK versions:** GTK 2, GTK 3  
**Applied via:** `gsettings` (Cinnamon schema)

### Applying the theme

```bash
gsettings set org.cinnamon.desktop.interface gtk-theme "Simplicity"
gsettings set org.cinnamon.desktop.wm.preferences theme "Simplicity"
gsettings set org.cinnamon.theme name "Simplicity"
```

### GUI method

**System Settings → Themes** → set each category:
- **Window borders** → Simplicity
- **Controls** → Simplicity

---

## KDE Plasma

**WM theme:** KWin (separate theming; GTK theme applies to GTK apps only)  
**GTK versions:** GTK 2, GTK 3, GTK 4  
**Applied via:** GTK settings file or System Settings

KDE Plasma does not use a GTK window manager theme for its own windows. However, GTK applications running inside Plasma will use the Simplicity GTK theme.

### System Settings (GUI)

1. Open **System Settings → Appearance → Application Style**
2. Click **Configure GNOME/GTK Application Style…**
3. In the **GTK3 theme** dropdown, select **Simplicity**
4. Click **Apply**

### Via settings file

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
gtk-icon-theme-name=Simplicity-Icons
```

```ini
# ~/.config/gtk-4.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

---

## LXDE

**WM theme:** Openbox  
**GTK versions:** GTK 2, GTK 3  
**Applied via:** LXDE Appearance Settings

### GUI method

**Preferences → Appearance Settings → Widget** tab → select **Simplicity**.

### Via settings file

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
```

---

## LXQt

**WM theme:** Openbox (default) or KWin  
**GTK versions:** GTK 2, GTK 3 (for GTK apps running inside LXQt)  
**Applied via:** GTK settings file or LXDE Configuration Centre

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

---

## i3

**WM theme:** i3 uses its own border/titlebar styling (independent of GTK)  
**GTK versions:** GTK 2, GTK 3, GTK 4  
**Applied via:** GTK settings file

i3 does not manage GTK theming. Apply the theme via the GTK settings file so that all GTK applications launched from within i3 use Simplicity.

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

To make GTK theming persistent across reboots, add to your `~/.xinitrc` or `~/.profile`:

```bash
export GTK_THEME=Simplicity
```

To match i3's own window borders with the Simplicity palette, add to your `~/.config/i3/config`:

```
# i3 window borders — Simplicity dark palette
# class             border    backgr.   text      indicator child_border
client.focused      #5294e2   #252525   #e0e0e0   #5294e2   #5294e2
client.focused_inactive #404040 #252525 #888888   #404040   #404040
client.unfocused    #404040   #2d2d2d   #666666   #404040   #2d2d2d
client.urgent       #cf6679   #cf6679   #ffffff   #cf6679   #cf6679
```

---

## Sway (Wayland)

**WM theme:** Sway uses its own border styling  
**GTK versions:** GTK 3, GTK 4  
**Applied via:** GTK settings file + `gsettings`

For Wayland (XDG), apply the theme via the settings portal or the GTK settings file:

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

```ini
# ~/.config/gtk-4.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

To also update the `gsettings` store (used by some Wayland apps):

```bash
gsettings set org.gnome.desktop.interface gtk-theme "Simplicity"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
```

Sway window border colours (add to `~/.config/sway/config`):

```
# Sway window colours — Simplicity dark palette
# class             border    backgr.   text      indicator child_border
client.focused      #5294e2   #252525   #e0e0e0   #5294e2   #5294e2
client.focused_inactive #404040 #252525 #888888   #404040   #404040
client.unfocused    #404040   #2d2d2d   #666666   #404040   #2d2d2d
client.urgent       #cf6679   #cf6679   #ffffff   #cf6679   #cf6679
```

---

## Openbox (standalone)

**WM theme:** Openbox (`openbox-3/themerc`)  
**GTK versions:** GTK 2, GTK 3  
**Applied via:** `openbox-3/themerc` (already included) + GTK settings file

The Openbox window manager theme is installed automatically by `install.sh` as part of the main theme bundle. To manually set it:

1. Copy the `openbox-3/` directory to `~/.themes/Simplicity/openbox-3/`
2. Reload Openbox: `openbox --reconfigure`
3. Or via **ObConf → Theme** → select **Simplicity**

For GTK applications inside Openbox, write the GTK settings file:

```ini
# ~/.config/gtk-3.0/settings.ini
[Settings]
gtk-theme-name=Simplicity
gtk-application-prefer-dark-theme=0
```

---

## After Applying

After applying the theme with any of the above methods, some applications may require a restart to pick up the new theme. Others update instantly.

If changes are not taking full effect after applying:

1. Log out and back in to reload the desktop session
2. Restart individual applications
3. On GNOME: run `killall -3 gnome-shell` to reload the shell (X11 only)
