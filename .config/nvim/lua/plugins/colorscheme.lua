-- ─────────────────────────────────────────────
--  plugins/colorscheme.lua
--  Theme — Tokyo Night, matches your purple terminal
-- ─────────────────────────────────────────────

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,     -- load immediately
    priority = 1000,  -- load before everything else
    opts = {
      style = "night",          -- night | storm | moon | day
      transparent = true,       -- match your ghostty transparency
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        -- Tweak to match your purple ghostty background
        hl.LineNr = { fg = c.dark5 }
        hl.CursorLineNr = { fg = c.orange, bold = true }
        hl.ColorColumn = { bg = c.bg_highlight }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight-night")
    end,
  },
}
