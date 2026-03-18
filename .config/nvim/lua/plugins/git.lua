-- ─────────────────────────────────────────────
--  plugins/git.lua
--  Git integration: inline blame, hunk previews,
--  staging, and a full git UI
-- ─────────────────────────────────────────────

return {

  -- ── Gitsigns: inline git decorations ────────
  -- Shows added/changed/removed lines in the sign column
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set

        -- Navigation
        map("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next hunk" })
        map("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Prev hunk" })

        -- Actions
        map("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        map("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
        map("n", "<leader>gS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
        map("n", "<leader>gR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
        map("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
        map("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
        map("n", "<leader>gD", function() gs.diffthis("~") end, { buffer = bufnr, desc = "Diff this ~" })

        -- Toggle
        map("n", "<leader>gtb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle blame" })
      end,
    },
  },

  -- ── Neogit: full git UI ──────────────────────
  -- Like Magit for Emacs — press <leader>gg to open
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",   -- beautiful diff views
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", ":Neogit<CR>", desc = "Open Neogit" },
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },

  -- ── Diffview: side-by-side diffs ────────────
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", ":DiffviewOpen<CR>", desc = "Open diffview" },
      { "<leader>gh", ":DiffviewFileHistory %<CR>", desc = "File history" },
    },
    opts = {},
  },
}
