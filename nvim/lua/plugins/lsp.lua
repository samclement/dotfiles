-- Native LSP configuration (replaces coc.nvim)

-- LSP settings
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Common on_attach function for LSP servers
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Keybindings (from coc.vim)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set

	-- Navigation (lines 61-68 from coc.vim)
	keymap("n", "[g", vim.diagnostic.goto_prev, opts)
	keymap("n", "]g", vim.diagnostic.goto_next, opts)
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "gy", vim.lsp.buf.type_definition, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)

	-- Hover documentation (line 71)
	keymap("n", "K", vim.lsp.buf.hover, opts)

	-- Symbol renaming (line 87)
	keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

	-- Formatting (lines 90-91)
	keymap("x", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
	keymap("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)

	-- Code actions (lines 103-104, 107, 109)
	keymap("x", "<leader>a", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>a", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>ac", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>qf", vim.lsp.buf.code_action, opts)

	-- Show diagnostics (line 153)
	keymap("n", "<space>a", vim.diagnostic.setloclist, opts)

	-- Highlight symbol under cursor (line 84)
	if client.server_capabilities.documentHighlightProvider then
		local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = highlight_group,
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = highlight_group,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = highlight_group,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

-- Configure LSP servers
local lspconfig = require("lspconfig")

-- TypeScript/JavaScript
-- Install: npm install -g typescript-language-server typescript
if vim.fn.executable("typescript-language-server") == 1 then
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Python
-- Install: pip install pyright
if vim.fn.executable("pyright") == 1 then
	lspconfig.pyright.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Lua
-- Install: brew install lua-language-server (macOS)
if vim.fn.executable("lua-language-server") == 1 then
	lspconfig.lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})
end

-- Rust
-- Install: rustup component add rust-analyzer
if vim.fn.executable("rust-analyzer") == 1 then
	lspconfig.rust_analyzer.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Go
-- Install: go install golang.org/x/tools/gopls@latest
if vim.fn.executable("gopls") == 1 then
	lspconfig.gopls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Diagnostic display settings
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Commands (lines 138, 141, 144 from coc.vim)
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = true })
end, {})

-- Note: CocList commands (lines 153-167) are now replaced by Telescope
-- :Telescope diagnostics (replaces CocList diagnostics)
-- :Telescope lsp_document_symbols (replaces CocList outline)
-- :Telescope lsp_workspace_symbols (replaces CocList symbols)
