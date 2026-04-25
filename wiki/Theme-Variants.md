# Theme Variants

> 🌐 **Translate this page:**
> [🇪🇸 Español](https://translate.google.com/translate?sl=en&tl=es&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇫🇷 Français](https://translate.google.com/translate?sl=en&tl=fr&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇩🇪 Deutsch](https://translate.google.com/translate?sl=en&tl=de&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇮🇹 Italiano](https://translate.google.com/translate?sl=en&tl=it&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇧🇷 Português](https://translate.google.com/translate?sl=en&tl=pt&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇷🇺 Русский](https://translate.google.com/translate?sl=en&tl=ru&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇨🇳 中文](https://translate.google.com/translate?sl=en&tl=zh-CN&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇯🇵 日本語](https://translate.google.com/translate?sl=en&tl=ja&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇰🇷 한국어](https://translate.google.com/translate?sl=en&tl=ko&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇸🇦 العربية](https://translate.google.com/translate?sl=en&tl=ar&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md) ·
> [🇮🇳 हिन्दी](https://translate.google.com/translate?sl=en&tl=hi&u=https://github.com/PhantomNimbi/Simplicity/blob/main/wiki/Theme-Variants.md)

Simplicity ships four distinct theme variants. Each is a self-contained set of files covering GTK 2, GTK 3, GTK 4, and all supported window managers.

---

## Simplicity (Dual-Tone) — Default

> **Theme name:** `Simplicity`  
> **Source directory:** `simplicity-dualtone/`

The default variant combines a **dark chrome** with a **light content area**, giving you the visual polish of a dark interface frame alongside the readability of a light document area.

![Dual-Tone variant](screenshots/variant-dualtone.png)

### What's dark
- Header bar (title bar and toolbar)
- Sidebar / navigation panel
- Menus and popovers
- Tooltips
- OSD (on-screen display overlays)

### What's light
- Main window body
- Text entry fields
- Tree views and list views
- Buttons (neutral state)
- Scrolled content areas

### Colour highlights
| Region | Background | Foreground |
|--------|-----------|-----------|
| Header bar | `#252525` | `#e0e0e0` |
| Sidebar | `#2a2a2a` | `#e0e0e0` |
| Content area | `#f5f5f5` | `#2d2d2d` |
| Text entries (base) | `#ffffff` | `#2d2d2d` |
| Accent / selection | `#5294e2` | `#ffffff` |

### When to use
Choose the Dual-Tone variant if you want:
- A distinctive "pro" look with clear visual separation between chrome and content
- Comfortable long-form reading (light background) with low eye-strain from the dark frame
- The appearance most designers associate with applications like VS Code or Spotify

---

## Simplicity-Dark — Full Dark

> **Theme name:** `Simplicity-Dark`  
> **Source directory:** `simplicity-dark/`

The full dark variant applies the dark palette consistently to every surface — header, content area, sidebars, inputs, and widgets.

![Dark variant](screenshots/variant-dark.png)

### Colour palette
| Role | Value |
|------|-------|
| Main background | `#2d2d2d` |
| Dark background (panels) | `#252525` |
| Base (inputs, trees) | `#1e1e1e` |
| Foreground / text | `#e0e0e0` |
| Borders | `#404040` |
| Button background | `#3a3a3a` |
| Button hover | `#484848` |
| Button pressed | `#2a2a2a` |
| Accent / selection | `#5294e2` |
| Tooltip background | `#1c1c1c` |

### When to use
Choose the Dark variant if you:
- Prefer a fully immersive dark environment — no light surfaces anywhere
- Work in low-light conditions for extended periods
- Use applications such as terminals, code editors, or media players where dark-everywhere is preferred

---

## Simplicity-Light — Full Light

> **Theme name:** `Simplicity-Light`  
> **Source directory:** `simplicity-light/`

The full light variant applies a clean light palette consistently across all surfaces.

![Light variant](screenshots/variant-light.png)

### Colour palette
| Role | Value |
|------|-------|
| Main background | `#f5f5f5` |
| Header / panel background | `#ebebeb` |
| Base (inputs, trees) | `#ffffff` |
| Foreground / text | `#2d2d2d` |
| Borders | `#d0d0d0` |
| Button background | `#e8e8e8` |
| Button hover | `#d8d8d8` |
| Button pressed | `#c8c8c8` |
| Accent / selection | `#5294e2` |
| Tooltip background | `#f0f0f0` |

### When to use
Choose the Light variant if you:
- Work in bright environments or on high-glare monitors
- Prefer the traditional desktop aesthetic
- Need maximum contrast for accessibility

---

## Simplicity-Dracula — Dracula Palette

> **Theme name:** `Simplicity-Dracula`  
> **Source directory:** `simplicity-dracula/`

The Dracula variant applies the iconic [Dracula colour palette](https://draculatheme.com) consistently across all surfaces — a full dark theme with deep-navy backgrounds and a distinctive purple accent colour.

![Dracula variant](screenshots/variant-dracula.png)

### Colour palette
| Role | Value |
|------|-------|
| Main background | `#282a36` |
| Dark background (panels) | `#21222c` |
| Deepest background | `#191a21` |
| Base (inputs, trees) | `#1e1f29` |
| Foreground / text | `#f8f8f2` |
| Borders | `#44475a` |
| Button background | `#383a4b` |
| Button hover | `#44475a` |
| Button pressed | `#282a36` |
| Accent / selection | `#bd93f9` (purple) |
| Error | `#ff5555` |
| Warning | `#ffb86c` |
| Success | `#50fa7b` |
| Link | `#8be9fd` |
| Tooltip background | `#191a21` |

### When to use
Choose the Dracula variant if you:
- Are already using the Dracula colour scheme across your terminal, editor, or other tools and want a consistent desktop
- Prefer the distinctive purple accent over the default blue
- Want a fully dark environment with a well-established, community-recognised palette

---

## Side-by-Side Comparison

| Element | Dark | Light | Dual-Tone | Dracula |
|---------|------|-------|-----------|---------|
| Header bar | `#252525` dark | `#ebebeb` light | `#252525` **dark** | `#21222c` dark |
| Sidebar | `#2a2a2a` dark | `#f0f0f0` light | `#2a2a2a` **dark** | `#21222c` dark |
| Window body | `#2d2d2d` dark | `#f5f5f5` light | `#f5f5f5` **light** | `#282a36` dark |
| Text entries | `#1e1e1e` dark | `#ffffff` light | `#ffffff` **light** | `#1e1f29` dark |
| Primary text | `#e0e0e0` light | `#2d2d2d` dark | mixed | `#f8f8f2` light |
| Accent colour | `#5294e2` blue | `#5294e2` blue | `#5294e2` blue | `#bd93f9` **purple** |
| GTK dark-mode flag | `1` (on) | `0` (off) | `0` (off) | `1` (on) |

All variants share the same error (`#cf6679` / `#ff5555`), warning (`#e5a050` / `#ffb86c`), and success (`#4caf50` / `#50fa7b`) colours within their respective palettes. The Dracula variant uses the Dracula-specific versions of these state colours.

---

## Installing Multiple Variants

You can install all variants in a single command:

```bash
./install.sh --dark --light --dracula
```

This installs:
- `Simplicity` (dual-tone) → `~/.themes/Simplicity/`
- `Simplicity-Dark` → `~/.themes/Simplicity-Dark/`
- `Simplicity-Light` → `~/.themes/Simplicity-Light/`
- `Simplicity-Dracula` → `~/.themes/Simplicity-Dracula/`

To switch between installed variants without reinstalling:

```bash
# Apply the dark variant
./scripts/apply-theme.sh --dark

# Apply the light variant
./scripts/apply-theme.sh --light

# Apply the Dracula variant
./scripts/apply-theme.sh --dracula

# Apply the default dual-tone variant
./scripts/apply-theme.sh
```
