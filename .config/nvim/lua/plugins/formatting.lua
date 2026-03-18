-- ─────────────────────────────────────────────
--  plugins/formatting.lua
--  Formatting (conform) and linting (nvim-lint)
-- ─────────────────────────────────────────────

return {

  -- ── Conform: auto-formatting ─────────────────
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    keys = {
      { "<leader>lf", function() require("conform").format({ async = true }) end, desc = "Format file" },
    },
    opts = {
      formatters_by_ft = {
        python     = { "black", "isort" },
        go         = { "gofmt", "goimports" },
        rust       = { "rustfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        jsx        = { "prettier" },
        tsx        = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier" },
        css        = { "prettier" },
        html       = { "prettier" },
        terraform  = { "terraform_fmt" },
        sh         = { "shfmt" },
        lua        = { "stylua" },
      },
      -- Format on save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,   -- fall back to LSP formatter if none defined
      },
    },
  },

  -- ── nvim-lint: linting ───────────────────────
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python     = { "flake8" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        yaml       = { "yamllint" },
        terraform  = { "tflint" },
        sh         = { "shellcheck" },
        dockerfile = { "hadolint" },
      }
      -- Run linter on save and when entering a buffer
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  -- ── Mason tool installer ─────────────────────
  -- Auto-installs formatters and linters via Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters
        "black",        -- Python formatter
        "isort",        -- Python import sorter
        "prettier",     -- JS/TS/JSON/YAML/MD formatter
        "stylua",       -- Lua formatter
        "shfmt",        -- Shell formatter
        -- Linters
        "flake8",       -- Python linter
        "eslint_d",     -- JS/TS linter (fast daemon)
        "yamllint",     -- YAML linter
        "shellcheck",   -- Shell linter
        "hadolint",     -- Dockerfile linter
        "tflint",       -- Terraform linter
      },
    },
  },
}
