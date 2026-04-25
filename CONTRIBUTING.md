# Contributing to Simplicity

> 🌐 **Translate this page:**
> [🇪🇸 Español](https://translate.google.com/translate?sl=en&tl=es&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇫🇷 Français](https://translate.google.com/translate?sl=en&tl=fr&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇩🇪 Deutsch](https://translate.google.com/translate?sl=en&tl=de&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇮🇹 Italiano](https://translate.google.com/translate?sl=en&tl=it&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇧🇷 Português](https://translate.google.com/translate?sl=en&tl=pt&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇷🇺 Русский](https://translate.google.com/translate?sl=en&tl=ru&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇨🇳 中文](https://translate.google.com/translate?sl=en&tl=zh-CN&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇯🇵 日本語](https://translate.google.com/translate?sl=en&tl=ja&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇰🇷 한국어](https://translate.google.com/translate?sl=en&tl=ko&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇸🇦 العربية](https://translate.google.com/translate?sl=en&tl=ar&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md) ·
> [🇮🇳 हिन्दी](https://translate.google.com/translate?sl=en&tl=hi&u=https://github.com/PhantomNimbi/Simplicity/blob/main/CONTRIBUTING.md)

Thank you for your interest in contributing to Simplicity! Whether you are fixing a bug, adding support for a new Linux distribution, improving the theme, or updating documentation, your help is appreciated.

Please read the guidelines below before opening an issue or submitting a pull request.

---

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [How to Contribute](#how-to-contribute)
   - [Reporting Bugs](#reporting-bugs)
   - [Suggesting Features or Improvements](#suggesting-features-or-improvements)
   - [Contributing Code](#contributing-code)
4. [Development Guidelines](#development-guidelines)
   - [Repository Structure](#repository-structure)
   - [Theme Files](#theme-files)
   - [Shell Scripts](#shell-scripts)
   - [Adding Distribution Support](#adding-distribution-support)
5. [Commit Message Conventions](#commit-message-conventions)
6. [Pull Request Process](#pull-request-process)
7. [Testing Your Changes](#testing-your-changes)
8. [Documentation](#documentation)
9. [Licence](#licence)

---

## Code of Conduct

Be respectful and constructive in all project spaces. Rude, dismissive, or harassing behaviour will not be tolerated. When in doubt, assume good faith and focus on the work.

---

## Getting Started

1. **Fork** the repository and clone your fork locally:

   ```bash
   git clone https://github.com/<your-username>/Simplicity.git
   cd Simplicity
   ```

2. Create a **dedicated branch** for your change — do not work directly on `main`:

   ```bash
   git checkout -b feat/my-feature
   # or
   git checkout -b fix/issue-123
   ```

3. Make your changes, then push to your fork and open a pull request.

---

## How to Contribute

### Reporting Bugs

Before opening a bug report, please:

- Search [existing issues](https://github.com/PhantomNimbi/Simplicity/issues) to check whether the bug has already been reported.
- Confirm the issue exists with the latest version of the theme.

When you open a bug report, use the **Bug Report** issue template and fill in all sections, including:

- Your Linux distribution, desktop environment, GTK version, and display server.
- The installation method you used.
- Clear steps to reproduce the problem.
- Screenshots if the issue is visual.

The more detail you provide, the faster the issue can be investigated.

### Suggesting Features or Improvements

Open an issue and describe:

- **What** you would like added or changed.
- **Why** it would benefit users of Simplicity.
- Any relevant examples, screenshots, or references.

For large changes (new theme variants, major installer refactors, new DE support), open an issue for discussion *before* investing time in a pull request. This avoids duplicated effort and makes it easier to align on the right approach.

### Contributing Code

All code contributions are made via pull requests from a fork:

1. Open (or reference) an issue that describes the problem or feature.
2. Create a branch, make your changes, and push to your fork.
3. Open a pull request against the `main` branch with a clear description of what you changed and why.
4. Respond to any review feedback promptly.

---

## Development Guidelines

### Repository Structure

Before making changes, familiarise yourself with how the project is organised:

```
Simplicity/
├── install.sh                  # Main installer (auto-detects distro)
├── uninstall.sh                # Uninstaller
├── scripts/
│   ├── detect-distro.sh        # Distro and package-manager detection
│   └── apply-theme.sh          # Desktop-environment-aware theme applicator
├── simplicity-dualtone/        # Default (dual-tone) theme variant
├── simplicity-light/           # Full light theme variant
├── simplicity-dark/            # Full dark theme variant
└── distros/                    # Per-distro dependency installers
    ├── ubuntu/
    ├── debian/
    ├── fedora/
    ├── arch/
    ├── manjaro/
    └── opensuse/
```

Each theme variant follows the same directory layout:

```
<variant>/
├── index.theme
├── cinnamon/cinnamon.css
├── gnome-shell/gnome-shell.css
├── gtk-2.0/gtkrc
├── gtk-3.0/gtk.css
├── gtk-3.0/settings.ini
├── gtk-4.0/gtk.css
├── metacity-1/metacity-theme-3.xml
├── xfwm4/themerc
└── openbox-3/themerc
```

### Theme Files

- **Colour changes** should be made through the `@define-color` variables at the top of each `gtk.css` file. Avoid hard-coding hex values in widget rules.
- **Apply the same colour change** consistently across all relevant files in a variant: `gtk-2.0/gtkrc`, `gtk-3.0/gtk.css`, `gtk-4.0/gtk.css`, `gnome-shell/gnome-shell.css`, `cinnamon/cinnamon.css`, `metacity-1/metacity-theme-3.xml`, `xfwm4/themerc`, and `openbox-3/themerc`.
- **Test all three variants** (dual-tone, light, dark) if your change affects shared logic or colours.
- Preserve the existing comment style (`/* === Section === */`) in CSS files.
- Do not introduce external assets (fonts, icon sets, images) without prior discussion.

### Shell Scripts

- All scripts must be written in **`bash`**. Do not use `zsh`, `fish`, or other shells.
- Use `set -euo pipefail` at the top of any new script.
- Print user-facing messages with consistent prefixes already used in the project (`[INFO]`, `[OK]`, `[WARN]`, `[ERROR]`).
- New flags or options in `install.sh` or `apply-theme.sh` must be documented in the `--help` output and in `README.md`.
- Keep scripts idempotent where possible — running them a second time should not break anything.

### Adding Distribution Support

To add a new Linux distribution installer:

1. Create a new directory: `distros/<distro-name>/`
2. Add an `install.sh` modelled on an existing distro installer. At minimum it must:
   - Install the GTK engine packages required by the theme.
   - Exit cleanly with an appropriate message if dependencies are already satisfied.
3. Add a `README.md` inside the directory with any distro-specific notes.
4. Register the distro in the `install_distro_specific` function of the root `install.sh`:
   ```bash
   <distro-id>)
       distro_installer="${SCRIPT_DIR}/distros/<distro-name>/install.sh"
       ;;
   ```
5. Add detection logic in `scripts/detect-distro.sh` if the distro family is not already covered.
6. Update the **Supported Linux Distributions** table in `README.md`.

---

## Commit Message Conventions

Use the [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <short summary>
```

| Type | When to use |
|------|-------------|
| `feat` | A new feature or new distribution/DE support |
| `fix` | A bug fix |
| `style` | Theme or CSS visual change (no functional change) |
| `refactor` | Code restructuring with no behaviour change |
| `docs` | Documentation-only change |
| `chore` | Build scripts, CI config, or other housekeeping |

**Examples:**

```
feat(distros): add openSUSE MicroOS installer
fix(gtk3): correct selected-text colour in dark variant
style(dualtone): adjust sidebar hover shade
docs: document --dual-tone flag in README
chore(ci): add release workflow for tag-triggered builds
```

Guidelines:
- Keep the summary line under **72 characters**.
- Use the imperative mood ("add", "fix", "update" — not "added" or "fixes").
- Reference related issues in the commit body or footer: `Closes #42`.
- Separate the summary from the body with a blank line when a body is needed.

---

## Pull Request Process

1. **One concern per PR.** A pull request should address a single bug, feature, or improvement. Avoid bundling unrelated changes.
2. **Fill in the PR description** — explain what you changed, why, and any relevant context. Reference the related issue (`Closes #N`).
3. **Keep diffs small and focused.** Reviewers are much faster with tight, readable diffs. Large refactors should be discussed in an issue first.
4. **Ensure your branch is up to date** with `main` before opening the PR.
5. **Do not force-push** to a branch that already has a pull request open, unless you have been asked to rebase.
6. The PR will be reviewed by a maintainer. Please respond to review comments within a reasonable time. PRs with no activity for 30 days may be closed.
7. Once approved and all feedback is addressed, a maintainer will merge the PR.

---

## Testing Your Changes

Before submitting a pull request, verify that your changes work end-to-end:

```bash
# Install without applying immediately
chmod +x install.sh
./install.sh --no-apply

# Preview what apply-theme.sh would do
./scripts/apply-theme.sh --dry-run

# Apply the theme to the current session
./scripts/apply-theme.sh
```

Check the following:

- [ ] The theme installs without errors on at least one supported distribution.
- [ ] The affected theme variant renders correctly in a GTK 3 or GTK 4 application.
- [ ] Shell scripts exit with code `0` on success and a non-zero code on error.
- [ ] No unintended files are included in the diff (build artefacts, editor config, etc.).

If you do not have access to a suitable test environment, note that in the PR description and a maintainer may be able to help test.

---

## Documentation

- Update `README.md` whenever you add new installer flags, new distributions, new DE support, or any user-facing behaviour.
- Update `CHANGELOG.md` under the `[Unreleased]` section following the existing format.
- If you add a new installer flag or script option, document it in the relevant `--help` output as well as in `README.md`.
- Spell-check documentation before submitting. This project uses **British English** spelling (e.g. *colour*, *behaviour*, *licence*).

---

## Licence

By contributing to Simplicity you agree that your contributions will be licensed under the **BSD 3-Clause License**, the same licence that covers the project. See [LICENSE](LICENSE) for the full text.
