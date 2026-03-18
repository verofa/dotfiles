-- ─────────────────────────────────────────────
--  plugins/treesitter.lua
--  nvim-treesitter v1 compatible config
-- ─────────────────────────────────────────────

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		lazy = false, -- load immediately, not lazily
		priority = 900, -- load early, right after colorscheme
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		main = "nvim-treesitter.config",
		opts = { -- change config = function() to opts = {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"python",
				"go",
				"rust",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"jsonc",
				"yaml",
				"toml",
				"terraform",
				"hcl",
				"bash",
				"fish",
				"dockerfile",
				"html",
				"css",
				"markdown",
				"markdown_inline",
				"regex",
				"comment",
				"git_config",
				"gitcommit",
				"gitignore",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_prev_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
			},
		}, -- close opts here, no config function needed
	},
}
