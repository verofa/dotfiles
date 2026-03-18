starship init fish | source
# ── NVM ───────────────────────────────────────
load_nvm

# ── PATH additions ────────────────────────────
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin

set -gx EZA_CONFIG_DIR ~/.config/eza

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2026-03-01 01:46:33
set PATH $PATH /Users/verogo/.local/bin


# ── Config & data formats ─────────────────────
set -gx LS_COLORS "$LS_COLORS:*.yml=38;5;220"    # YAML         — gold
set -gx LS_COLORS "$LS_COLORS:*.yaml=38;5;220"   # YAML         — gold
set -gx LS_COLORS "$LS_COLORS:*.json=38;5;117"   # JSON         — sky cyan
set -gx LS_COLORS "$LS_COLORS:*.toml=38;5;220"   # TOML         — gold
set -gx LS_COLORS "$LS_COLORS:*.env=38;5;208"    # .env         — orange
set -gx LS_COLORS "$LS_COLORS:*.ini=38;5;220"    # ini          — gold
set -gx LS_COLORS "$LS_COLORS:*.conf=38;5;220"   # conf         — gold
set -gx LS_COLORS "$LS_COLORS:*.xml=38;5;117"    # XML          — sky cyan
set -gx LS_COLORS "$LS_COLORS:*.csv=38;5;156"    # CSV          — light green

# ── Infrastructure & cloud ────────────────────
set -gx LS_COLORS "$LS_COLORS:*.tf=38;5;135"     # Terraform    — purple
set -gx LS_COLORS "$LS_COLORS:*.tfvars=38;5;99"  # TF vars      — muted purple
set -gx LS_COLORS "$LS_COLORS:*.hcl=38;5;135"    # HCL          — purple

# ── Source code ───────────────────────────────
set -gx LS_COLORS "$LS_COLORS:*.py=38;5;33"      # Python       — blue
set -gx LS_COLORS "$LS_COLORS:*.go=38;5;81"      # Go           — cyan
set -gx LS_COLORS "$LS_COLORS:*.rs=38;5;208"     # Rust         — orange
set -gx LS_COLORS "$LS_COLORS:*.js=38;5;226"     # JavaScript   — yellow
set -gx LS_COLORS "$LS_COLORS:*.ts=38;5;75"      # TypeScript   — cornflower
set -gx LS_COLORS "$LS_COLORS:*.jsx=38;5;226"    # JSX          — yellow
set -gx LS_COLORS "$LS_COLORS:*.tsx=38;5;75"     # TSX          — cornflower
set -gx LS_COLORS "$LS_COLORS:*.sh=38;5;113"     # Shell        — green
set -gx LS_COLORS "$LS_COLORS:*.fish=38;5;113"   # Fish script  — green
set -gx LS_COLORS "$LS_COLORS:*.java=38;5;214"   # Java         — amber
set -gx LS_COLORS "$LS_COLORS:*.rb=38;5;196"     # Ruby         — red
set -gx LS_COLORS "$LS_COLORS:*.php=38;5;105"    # PHP          — purple

# ── Docs ──────────────────────────────────────
set -gx LS_COLORS "$LS_COLORS:*.md=38;5;183"     # Markdown     — lavender
set -gx LS_COLORS "$LS_COLORS:*.txt=38;5;189"    # Text         — soft white
set -gx LS_COLORS "$LS_COLORS:*.pdf=38;5;203"    # PDF          — salmon

# ── Media ─────────────────────────────────────
set -gx LS_COLORS "$LS_COLORS:*.png=38;5;175"    # PNG          — pink
set -gx LS_COLORS "$LS_COLORS:*.jpg=38;5;175"    # JPG          — pink
set -gx LS_COLORS "$LS_COLORS:*.jpeg=38;5;175"   # JPEG         — pink
set -gx LS_COLORS "$LS_COLORS:*.gif=38;5;175"    # GIF          — pink
set -gx LS_COLORS "$LS_COLORS:*.svg=38;5;175"    # SVG          — pink
set -gx LS_COLORS "$LS_COLORS:*.mp4=38;5;168"    # MP4          — mauve
set -gx LS_COLORS "$LS_COLORS:*.mp3=38;5;168"    # MP3          — mauve

# ── Archives ──────────────────────────────────
set -gx LS_COLORS "$LS_COLORS:*.zip=38;5;227"    # ZIP          — light yellow
set -gx LS_COLORS "$LS_COLORS:*.tar=38;5;227"    # TAR          — light yellow
set -gx LS_COLORS "$LS_COLORS:*.gz=38;5;227"     # GZ           — light yellow

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
