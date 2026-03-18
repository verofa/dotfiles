-- ─────────────────────────────────────────────
--  plugins/editor.lua
--  Quality of life editor enhancements:
--  autopairs, surround, comments, leap motion
-- ─────────────────────────────────────────────

return {

	-- ── Auto pairs ──────────────────────────────
	-- Automatically closes (, [, {, ", ', `
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true, -- use treesitter to check context
			ts_config = {
				lua = { "string" }, -- don't add pairs inside lua strings
				javascript = { "template_string" },
			},
		},
	},

	-- ── Surround ────────────────────────────────
	-- Add/change/delete surrounding chars
	-- ys + motion + char  → add surround
	-- cs + old + new      → change surround
	-- ds + char           → delete surround
	-- Example: ysiw" wraps word in quotes, cs"' changes " to '
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},

	-- ── Comments ────────────────────────────────
	-- gcc → toggle line comment
	-- gbc → toggle block comment
	-- gc + motion → comment motion (e.g. gcip = comment paragraph)
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},

	-- ── Leap: fast cursor motion ─────────────────
	-- s + two chars → jump anywhere on screen instantly
	-- S → jump backwards
	{
		-- "ggandor/leap.nvim",
		url = "https://codeberg.org/andyg/leap.nvim.git",
		event = "VeryLazy",
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	-- ── Todo comments ────────────────────────────
	-- Highlights TODO:, FIXME:, HACK:, NOTE:, WARN:
	-- <leader>ft to search all todos via Telescope
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ft", ":TodoTelescope<CR>", desc = "Find TODOs" },
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next TODO",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Prev TODO",
			},
		},
		opts = {},
	},

	-- ── Trouble: diagnostics panel ───────────────
	-- <leader>xx → toggle diagnostics panel
	-- Shows all errors/warnings in a nice list
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", ":Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
			{ "<leader>xd", ":Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
			{ "<leader>xl", ":Trouble loclist toggle<CR>", desc = "Location list" },
			{ "<leader>xq", ":Trouble qflist toggle<CR>", desc = "Quickfix list" },
		},
		opts = {},
	},

	-- ── Flash: enhanced f/t motion ───────────────
	-- Enhances f, F, t, T with visible jump targets
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash treesitter",
			},
		},
	},

	-- ── Hardtime: break bad vim habits ───────────
	-- Warns when you use hjkl repeatedly instead of motions
	-- Comment out if too annoying!
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_filetypes = { "neo-tree", "lazy", "mason", "help" },
			max_count = 4, -- warn after 4 repeated hjkl presses
		},
	},

	-- ── Mini.nvim utilities ──────────────────────
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Highlight word under cursor everywhere it appears
			require("mini.cursorword").setup()
			-- Animate scrolling
			require("mini.animate").setup({
				scroll = { enable = false }, -- disable scroll animation (can feel laggy)
			})
		end,
	},
}
