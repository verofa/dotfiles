-- ─────────────────────────────────────────────
--  plugins/telescope.lua
--  Fuzzy finder — find files, grep, buffers,
--  git commits, LSP symbols and more
-- ─────────────────────────────────────────────

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Native FZF sorter — much faster
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"nvim-telescope/telescope-ui-select.nvim", -- use telescope for vim.ui.select
		},
		config = function()
			-- Compatibility shim for nvim-treesitter v1 API changes
			-- Telescope still uses old API namges that were renamed in v1
			local ok, parsers = pcall(require, "nvim-treesitter.parsers")
			if ok then
				-- ft_to_lang was renamed to get_lang
				if parsers.ft_to_lang == nil then
					parsers.ft_to_lang = parsers.get_lang
				end
				-- get_buf_lang was removed use vim.treesitter.language.get_lang
				if parsers.get_buf_lang == nil then
					parsers.get_buf_lang = function(buf)
						return vim.treesitter.language.get_lang(vim.bo[buf].filetype) or vim.bo[buf].filetype
					end
				end
			end

			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					prompt_prefix = "  ",
					selection_caret = " ",
					path_display = { "truncate" },
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = { prompt_position = "top", preview_width = 0.55 },
						vertical = { mirror = false },
						width = 0.87,
						height = 0.80,
					},
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<Esc>"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = { hidden = true }, -- include dotfiles
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
	},
}
