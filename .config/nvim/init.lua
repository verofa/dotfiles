-- ─────────────────────────────────────────────
--  Neovim Config — init.lua
--  Entry point — loads all modules in order
-- ─────────────────────────────────────────────

require("core.options")    -- general settings
require("core.keymaps")    -- keybindings
require("core.autocmds")   -- autocommands
require("core.lazy")       -- plugin manager bootstrap
