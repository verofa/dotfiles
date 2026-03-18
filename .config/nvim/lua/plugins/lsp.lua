-- ─────────────────────────────────────────────
--  plugins/lsp.lua
--  Language Server Protocol — Neovim 0.11+
-- ─────────────────────────────────────────────

return {
	-- Mason: installs LSP servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- mason-lspconfig: auto-installs servers via Mason
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"gopls",
				"rust_analyzer",
				"ts_ls",
				"yamlls",
				"jsonls",
				"terraformls",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"cssls",
				"html",
			},
			automatic_installation = true,
		},
	},

	-- nvim-lspconfig: MUST load eagerly so its lsp/ configs
	-- are on the runtimepath before vim.lsp.enable() is called
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- ← critical: load immediately so lsp/ dir is available
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- ── Diagnostic signs ──────────────────────
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = true },
			})

			-- ── LSP keymaps on attach ─────────────────
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local map = vim.keymap.set
					local buf = ev.buf
					map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = buf })
					map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = buf })
					map("n", "gr", vim.lsp.buf.references, { desc = "Go to references", buffer = buf })
					map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = buf })
					map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs", buffer = buf })
					map("n", "<C-s>", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = buf })
					map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = buf })
					map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = buf })
					map("n", "<leader>lf", function()
						vim.lsp.buf.format({ async = true })
					end, { desc = "Format file", buffer = buf })
					map("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "Type definition", buffer = buf })
				end,
			})

			-- ── Shared capabilities for ALL servers ───
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- ── Per-server setting overrides ──────────
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			})

			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemas = {
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
						},
						validate = true,
						completion = true,
						hover = true,
					},
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			})

			-- ── Enable servers ────────────────────────
			-- nvim-lspconfig's lsp/ dir provides cmd, filetypes
			-- and root_markers — we just activate them here
			vim.lsp.enable({
				"lua_ls",
				"pyright",
				"gopls",
				"rust_analyzer",
				"ts_ls",
				"yamlls",
				"jsonls",
				"terraformls",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"cssls",
				"html",
			})
		end,
	},
}
