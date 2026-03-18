-- ─────────────────────────────────────────────
--  core/lazy.lua
--  Plugin manager bootstrap + plugin loading
--  Lazy.nvim: https://github.com/folke/lazy.nvim
-- ─────────────────────────────────────────────

-- Auto-install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins from lua/plugins/
require("lazy").setup("plugins", {
  change_detection = { notify = false },  -- don't notify on config change
  checker = { enabled = true, notify = false },  -- auto-check for updates silently
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
})
