-- ─────────────────────────────────────────────
--  plugins/completion.lua
--  Autocompletion engine (nvim-cmp)
--  Sources: LSP, buffer, path, snippets
-- ─────────────────────────────────────────────

return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-buffer", -- words from current buffer
			"hrsh7th/cmp-path", -- file system paths
			"hrsh7th/cmp-cmdline", -- command line completions
			"saadparwaiz1/cmp_luasnip", -- snippet completions
			{
				"L3MON4D3/LuaSnip", -- snippet engine
				build = "make install_jsregexp",
				dependencies = {
					"rafamadriz/friendly-snippets", -- pre-built snippets for many languages
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"onsails/lspkind.nvim", -- VSCode-style icons in completion menu
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), -- prev item
					["<C-j>"] = cmp.mapping.select_next_item(), -- next item
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- trigger completion
					["<C-e>"] = cmp.mapping.abort(), -- close completion
					-- Initial confiduration
					-- ["<CR>"] = cmp.mapping.confirm({ select = false }), -- confirm selection
					-- Accepts ([y]es the completion)
					-- This will auto-import if yout LSP suppports it.
					-- This will expand snippets if the LSP sent a snippet.
					-- https://youtu.be/m8C0Cq9Uv9o?si=BOVXjpLDc3p2rO9Z&t=1696
					-- ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- confirm selection

					-- Tab: confirm or jump to next snippet placeholder
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 },
					{ name = "luasnip", priority = 750 },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})

			-- Cmdline completion for /
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			-- Cmdline completion for :
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
		end,
	},
}
