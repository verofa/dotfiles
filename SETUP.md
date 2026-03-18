# 🛠️ Fresh Machine Setup Guide

Complete step-by-step instructions to set up the full developer terminal environment on a new macOS machine.

> ⏱️ **Estimated time:** 30–45 minutes on a fresh machine

---

## 📋 Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Homebrew](#2-homebrew)
3. [Fish Shell](#3-fish-shell)
4. [Core Tools](#4-core-tools)
5. [Fonts](#5-fonts)
6. [Node.js via nvm](#6-nodejs-via-nvm)
7. [Go](#7-go)
8. [Cloud CLIs](#8-cloud-clis)
9. [Ghostty Terminal](#9-ghostty-terminal)
10. [Restore Dotfiles](#10-restore-dotfiles)
11. [Starship Prompt](#11-starship-prompt)
12. [Neovim](#12-neovim)
13. [Verification Checklist](#13-verification-checklist)
14. [Troubleshooting](#14-troubleshooting)

---

## 1. Prerequisites

Make sure you have the following before starting:

- macOS (Apple Silicon or Intel)
- Internet connection
- Terminal access (use the default macOS Terminal for the initial setup)
- GitHub account with SSH key configured

---

## 2. Homebrew

Homebrew is the macOS package manager. Everything else depends on it.

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon only — add Homebrew to PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Verify
brew --version
```

---

## 3. Fish Shell

```bash
# Install fish
brew install fish

# Add fish to the list of allowed shells
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells

# Set fish as default shell
chsh -s /opt/homebrew/bin/fish

# Restart your terminal and verify
fish --version
```

---

## 4. Core Tools

```fish
# Fuzzy finder, file search, text search
brew install fzf ripgrep fd

# Modern ls replacement
brew install eza

# Better cat with syntax highlighting
brew install bat

# GNU coreutils (required for LS_COLORS with ls on macOS)
brew install coreutils

# Tree-sitter CLI (for Neovim treesitter)
brew install tree-sitter

# Git (latest version)
brew install git

# GitHub CLI
brew install gh
```

---

## 5. Fonts

JetBrainsMono Nerd Font is required for icons in Starship, Neovim and eza.

```fish
# Install via Homebrew
brew install --cask font-jetbrains-mono-nerd-font
```

> After installing, set the font in your terminal:
> - **Ghostty:** already configured via `~/.config/ghostty/config`
> - **Other terminals:** set manually to `JetBrainsMono Nerd Font`

---

## 6. Node.js via nvm

> ⚠️ Do NOT install Node via Homebrew — use nvm for version management.
> nvm requires a fish-compatible wrapper (nvm.fish).

```fish
# Install fisher (fish plugin manager)
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install nvm.fish (fish-compatible nvm wrapper)
fisher install jorgebucaran/nvm.fish

# Install latest LTS Node
nvm install lts
nvm use lts

# Verify
node --version
npm --version
```

> ℹ️ The `load_nvm` function in `~/.config/fish/functions/load_nvm.fish` will
> auto-load nvm on startup and switch versions when entering a directory with `.nvmrc`.

---

## 7. Go

Required for Neovim LSP server `gopls` and Go development.

```fish
# Install Go
brew install go

# Verify
go version
```

> The `~/go/bin` path is already added to `$PATH` in `config.fish`.

---

## 8. Cloud CLIs

```fish
# AWS CLI
brew install awscli

# Google Cloud SDK
brew install --cask google-cloud-sdk

# Azure CLI
brew install azure-cli

# Terraform
brew install terraform

# Verify
aws --version
gcloud --version
az --version
terraform --version
```

---

## 9. Ghostty Terminal

```fish
# Install Ghostty
brew install --cask ghostty
```

> The config is restored automatically in Step 10 via dotfiles.
> Config location: `~/.config/ghostty/config`

---

## 10. Restore Dotfiles

This step restores all configuration files from the dotfiles repository.

```fish
# Clone the bare dotfiles repo
git clone --bare git@github.com:yourusername/dotfiles.git ~/.dotfiles

# Set up the dotfiles alias temporarily
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Check what files will be restored
dotfiles checkout

# If you get conflicts (existing default config files), back them up first:
mkdir -p ~/.config-backup
dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv ~/{} ~/.config-backup/{}

# Checkout all dotfiles
dotfiles checkout

# Hide untracked files
dotfiles config --local status.showUntrackedFiles no

# Reload fish config
source ~/.config/fish/config.fish
```

> After this step the following configs are restored:
> - `~/.config/ghostty/config` — Ghostty terminal
> - `~/.config/starship.toml` — Starship prompt
> - `~/.config/fish/config.fish` — Fish shell
> - `~/.config/fish/functions/` — Fish functions
> - `~/.config/nvim/` — Neovim
> - `~/.aws/config` — AWS profiles and regions
> - `~/.gitignore` — Global gitignore
> - `~/README.md` — This repo readme

---

## 11. Starship Prompt

```fish
# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Verify — should show your prompt immediately
starship --version
```

> The `starship init fish | source` line is already in `config.fish` so the
> prompt activates automatically after restoring dotfiles.

---

## 12. Neovim

### 12.1 Install Neovim

```fish
brew install neovim

# Verify — must be 0.11 or later
nvim --version
```

### 12.2 First Launch — Install Plugins

```fish
# Open Neovim — Lazy.nvim will auto-install all plugins
nvim
```

> Wait for Lazy.nvim to finish installing all 45 plugins. You will see a
> progress bar. When done press `q` to close the Lazy window.

### 12.3 Install LSP Servers

```fish
# Inside Neovim — install all language servers
:MasonUpdate
```

> Mason will install servers for: Lua, Python, Go, Rust, TypeScript,
> YAML, JSON, Terraform, Bash, Docker, CSS, HTML.
>
> ⚠️ Requires Node.js and Go to be installed first (Steps 6 and 7).

### 12.4 Install Treesitter Parsers

```fish
# Inside Neovim
:TSUpdate
```

### 12.5 Verify Everything

```fish
# Inside Neovim — run full health check
:checkhealth

# Check specific components
:checkhealth lsp
:checkhealth mason
:checkhealth nvim-treesitter
:checkhealth telescope
```

> ✅ Everything should show green. See [Troubleshooting](#14-troubleshooting)
> for known warnings and how to fix them.

---

## 13. Verification Checklist

Run through this after completing all steps:

```fish
# ── Terminal tools ─────────────────────────
nvim --version        # should be 0.11+
node --version        # should be v24+
npm --version
go version
fish --version
starship --version
eza --version
bat --version
fzf --version
rg --version          # ripgrep
fd --version
tree-sitter --version

# ── Cloud CLIs ─────────────────────────────
aws --version
gcloud --version
az --version
terraform --version

# ── Dotfiles ───────────────────────────────
dotfiles status       # should show clean or only your changes
```

**Inside Neovim:**
```vim
:checkhealth          " full health check
:Lazy                 " all 45 plugins loaded
:Mason                " all LSP servers installed
:TSUpdate             " all parsers up to date
```

**Test LSP is working:**
```fish
# Open a Python file and check LSP attaches
nvim test.py
```
```vim
:lua vim.print(vim.lsp.get_clients({ bufnr = 0 }))
" Should show pyright attached
```

---

## 14. Troubleshooting

### nvm not working in fish
```fish
# Symptom: node: command not found
# Fix: install nvm.fish wrapper
fisher install jorgebucaran/nvm.fish
nvm use lts
```

### Mason failing to install servers
```fish
# Symptom: failed to spawn process cmd='npm'
# Fix: make sure Node is installed and on PATH
which npm        # should return a path
node --version   # should return version
# If empty, run: nvm use lts
```

### LS_COLORS not working with ls
```fish
# Symptom: ls shows no colors but eza does
# Fix: macOS ships BSD ls — install GNU coreutils
brew install coreutils
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
source ~/.config/fish/config.fish
```

### Neovim treesitter module not found
```
# Symptom: module 'nvim-treesitter.configs' not found
# Fix: v1 renamed the module — use 'nvim-treesitter.config' (no 's')
# Already fixed in the config — if it appears, run:
:Lazy sync
```

### Telescope errors with treesitter
```
# Symptom: attempt to call field 'ft_to_lang' (a nil value)
# Fix: already handled via compatibility shim in telescope.lua
# If it reappears after a plugin update, run:
:Lazy sync
```

### LSP deprecation warning
```
# Symptom: The require('lspconfig') framework is deprecated
# Fix: already migrated to vim.lsp.config() API in lsp.lua
# Make sure lazy = false is set on nvim-lspconfig plugin
```

### LSP checkhealth config not found warnings
```
# Symptom: WARNING 'bashls' config not found
# Fix: nvim-lspconfig must have lazy = false so its lsp/ directory
# loads before vim.lsp.enable() is called
```

### Unknown filetype warnings in checkhealth
```
# Symptom: WARNING Unknown filetype 'yaml.docker-compose'
# Fix: already registered in autocmds.lua via vim.filetype.add()
# These warnings are cosmetic — LSP still works correctly
# Verify with: :set filetype? (when a docker-compose.yml is open)
```

### Dotfiles add is slow
```fish
# Symptom: dotfiles add takes 1+ minute
# Fix: add a .gitignore to stop git scanning entire home directory
cat > ~/.gitignore << 'EOF'
*
!.gitignore
!README.md
!.config/
!.config/**
!.aws/
!.aws/config
EOF

dotfiles config --local core.excludesFile /Users/yourusername/.gitignore
```

### which-key warnings
```
# Symptom: opts.window deprecated / old spec version
# Fix: already updated in ui.lua
# window → win
# wk.register() → wk.add()
```

---

> 💡 **Tip:** Keep this repo updated whenever you change a config file:
> ```fish
> dotfiles add ~/.config/starship.toml
> dotfiles commit -m "feat: update starship prompt"
> dotfiles push
> ```
