-- ─────────────────────────────────────────────
--  core/options.lua
--  General Neovim settings
-- ─────────────────────────────────────────────

local opt = vim.opt

-- ── Leader key ────────────────────────────────
-- Set before plugins load — Space is the most ergonomic choice
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── Line numbers ──────────────────────────────
opt.number = true           -- show absolute line number on current line
opt.relativenumber = true   -- show relative numbers on all other lines
                            -- (great for jumping: 5j, 12k)

-- ── Indentation ───────────────────────────────
opt.tabstop = 2             -- a tab = 2 spaces visually
opt.shiftwidth = 2          -- >> and << shift by 2
opt.expandtab = true        -- use spaces instead of tabs
opt.smartindent = true      -- auto-indent on new lines
opt.autoindent = true

-- ── Search ────────────────────────────────────
opt.ignorecase = true       -- case-insensitive search by default
opt.smartcase = true        -- but case-sensitive if you type uppercase
opt.hlsearch = true         -- highlight search results
opt.incsearch = true        -- show matches as you type

-- ── Appearance ────────────────────────────────
opt.termguicolors = true    -- full 24-bit color support
opt.signcolumn = "yes"      -- always show sign column (git, diagnostics)
opt.cursorline = true       -- highlight the current line
opt.scrolloff = 8           -- keep 8 lines above/below cursor when scrolling
opt.sidescrolloff = 8       -- keep 8 columns left/right
opt.wrap = false            -- don't wrap long lines
opt.colorcolumn = "100"     -- show a guide at column 100
opt.showmode = false        -- don't show -- INSERT -- (statusline does this)
opt.cmdheight = 1
opt.pumheight = 10          -- max items in completion popup

-- ── Splits ────────────────────────────────────
opt.splitright = true       -- vertical splits open to the right
opt.splitbelow = true       -- horizontal splits open below

-- ── Files ─────────────────────────────────────
opt.swapfile = false        -- no swap files
opt.backup = false          -- no backup files
opt.undofile = true         -- persistent undo (survives restarts!)
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- ── Performance ───────────────────────────────
opt.updatetime = 250        -- faster CursorHold events (used by LSP)
opt.timeoutlen = 400        -- time to wait for key sequence (ms)
opt.lazyredraw = false      -- don't use lazyredraw (breaks some plugins)

-- ── Clipboard ─────────────────────────────────
-- Sync with system clipboard — yank in nvim = available in macOS
opt.clipboard = "unnamedplus"

-- ── Completion ────────────────────────────────
opt.completeopt = { "menuone", "noselect" }

-- ── Misc ──────────────────────────────────────
opt.iskeyword:append("-")   -- treat kebab-case as one word
opt.backspace = { "indent", "eol", "start" }
opt.mouse = "a"             -- enable mouse support
opt.conceallevel = 0        -- show ` ` in markdown files
opt.list = true             -- show invisible characters
opt.listchars = {
  tab = "→ ",
  trail = "·",
  nbsp = "␣",
}
