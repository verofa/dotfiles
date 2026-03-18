-- ─────────────────────────────────────────────
--  plugins/ui.lua
--  Visual enhancements: statusline, explorer,
--  tabs, indent guides, notifications
-- ─────────────────────────────────────────────

return {

	-- ── Statusline ──────────────────────────────
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
				globalstatus = true,
				disabled_filetypes = { "neo-tree" },
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } }, -- relative path
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},

	-- ── File explorer ───────────────────────────
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle explorer" },
			{ "<leader>o", ":Neotree focus<CR>", desc = "Focus explorer" },
		},
		opts = {
			close_if_last_window = true,
			window = { width = 30 },
			filesystem = {
				filtered_items = {
					visible = true, -- show hidden files dimmed
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = { enabled = true },
			},
		},
	},

	-- ── Bufferline (tab bar) ────────────────────
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{ filetype = "neo-tree", text = "Explorer", padding = 1 },
				},
				show_buffer_close_icons = true,
				show_close_icon = false,
				separator_style = "thin",
			},
		},
	},

	-- ── Indent guides ───────────────────────────
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "│" },
			scope = { enabled = true },
		},
	},

	-- ── Notifications ───────────────────────────
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 2000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			render = "compact",
		},
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify") -- replace default notify
		end,
	},

	-- ── Which-key (shows keybinding hints) ──────
	-- Press <leader> and wait — shows all available keys
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			-- window = { border = "rounded" },
			win = { border = "rounded" },
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			-- Register group names
			wk.add({
				{ "<leader>f", group = "Find (Telescope)" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>s", group = "Splits" },
				{ "<leader>t", group = "Tabs / Terminal" },
				{ "<leader>b", group = "Buffers" },
			})
		end,
	},

	-- ── Colorizer (show hex colors inline) ──────
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			user_default_options = {
				css = true,
				tailwind = true,
				mode = "background",
			},
		},
	},

	-- ── Dashboard ───────────────────────────────
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
				"                                                     ",
			}
			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
				dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
				dashboard.button("e", "  Explorer", ":Neotree toggle<CR>"),
				dashboard.button("l", "  Lazy plugins", ":Lazy<CR>"),
				dashboard.button("q", "  Quit", ":qa<CR>"),
			}
			alpha.setup(dashboard.opts)
		end,
	},
}
