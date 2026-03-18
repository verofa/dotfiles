-- ─────────────────────────────────────────────
--  core/autocmds.lua
--  Automatic behaviors triggered by events
-- ─────────────────────────────────────────────

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ── Highlight on yank ─────────────────────────
-- Briefly flashes what you just yanked
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- ── Remove trailing whitespace on save ────────
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
	group = "TrimWhitespace",
	pattern = "*",
	callback = function()
		local save = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(save)
	end,
})

-- ── Restore cursor position ───────────────────
-- When reopening a file, jump to where you left off
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
	group = "RestoreCursor",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- ── Auto resize splits on window resize ───────
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
	group = "ResizeSplits",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- ── File type specific settings ───────────────
augroup("FileTypeSettings", { clear = true })

-- YAML / Terraform: 2 space indent
autocmd("FileType", {
	group = "FileTypeSettings",
	pattern = { "yaml", "yml", "terraform", "hcl" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

-- Python: 4 space indent (PEP8)
autocmd("FileType", {
	group = "FileTypeSettings",
	pattern = "python",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
		vim.opt_local.colorcolumn = "88" -- black formatter line length
	end,
})

-- Go: tabs (gofmt standard)
autocmd("FileType", {
	group = "FileTypeSettings",
	pattern = "go",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = false -- Go uses real tabs
	end,
})

-- Markdown: wrap text
autocmd("FileType", {
	group = "FileTypeSettings",
	pattern = { "markdown", "md" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
})

-- ── Close certain windows with q ──────────────
augroup("QuickClose", { clear = true })
autocmd("FileType", {
	group = "QuickClose",
	pattern = { "help", "qf", "lspinfo", "man", "checkhealth" },
	callback = function()
		vim.keymap.set("n", "q", ":close<CR>", { buffer = true, silent = true })
	end,
})

vim.filetype.add({
	extension = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
		[".gitlab-ci.yml"] = "yaml.gitlab",
	},
	pattern = {
		[".*%.gowork"] = "gowork",
		[".*%.gotmpl"] = "gotmpl",
		[".*%.tfvars"] = "terraform-vars",
		["helm/.*%.yaml"] = "yaml.helm-values",
		["templates/.*%.yaml"] = "yaml.helm-values",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
})
