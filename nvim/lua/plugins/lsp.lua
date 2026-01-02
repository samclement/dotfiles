-- Native LSP configuration (replaces coc.nvim)

-- Override the LSP floating window opener to always use borders
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSP settings
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Default config for all servers
local default_config = {
	capabilities = capabilities,
}

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

	-- Code actions (use actions-preview when available, fallback to default)
	keymap({ "n", "v" }, "<leader>a", function()
		local ok = pcall(require, "actions-preview")
		if ok then
			require("actions-preview").code_actions()
		else
			vim.lsp.buf.code_action()
		end
	end, opts)
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

-- Configure LSP servers using modern vim.lsp API
-- Add server configs
vim.lsp.config("*", default_config)

-- TypeScript/JavaScript (updated to ts_ls)
-- Install: npm install -g typescript-language-server typescript
if vim.fn.executable("typescript-language-server") == 1 then
	vim.lsp.enable("ts_ls")
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
		callback = function(args)
			vim.lsp.start({
				name = "ts_ls",
				cmd = { "typescript-language-server", "--stdio" },
				root_dir = vim.fs.root(args.buf, { "package.json", "tsconfig.json", "jsconfig.json" }),
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	})
end

-- Python
-- Install: pip install pyright
if vim.fn.executable("pyright") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function(args)
			vim.lsp.start({
				name = "pyright",
				cmd = { "pyright-langserver", "--stdio" },
				root_dir = vim.fs.root(args.buf, { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" }),
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	})
end

-- Lua
-- Install: brew install lua-language-server (macOS)
if vim.fn.executable("lua-language-server") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "lua",
		callback = function(args)
			vim.lsp.start({
				name = "lua_ls",
				cmd = { "lua-language-server" },
				root_dir = vim.fs.root(args.buf, { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" }),
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	})
end

-- Rust
-- Install: rustup component add rust-analyzer
if vim.fn.executable("rust-analyzer") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "rust",
		callback = function(args)
			vim.lsp.start({
				name = "rust_analyzer",
				cmd = { "rust-analyzer" },
				root_dir = vim.fs.root(args.buf, { "Cargo.toml", "rust-project.json" }),
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	})
end

-- Go
-- Install: go install golang.org/x/tools/gopls@latest
if vim.fn.executable("gopls") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "go",
		callback = function(args)
			vim.lsp.start({
				name = "gopls",
				cmd = { "gopls" },
				root_dir = vim.fs.root(args.buf, { "go.mod", "go.work" }),
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	})
end

-- HTML
-- Install: npm install -g vscode-langservers-extracted
if vim.fn.executable("vscode-html-language-server") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "html",
		callback = function(args)
			vim.lsp.start({
				name = "html",
				cmd = { "vscode-html-language-server", "--stdio" },
				root_dir = vim.fs.root(args.buf, { "package.json", ".git" }),
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	})
end

-- CSS
-- Install: npm install -g vscode-langservers-extracted
if vim.fn.executable("vscode-css-language-server") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "css", "scss", "less" },
		callback = function(args)
			vim.lsp.start({
				name = "cssls",
				cmd = { "vscode-css-language-server", "--stdio" },
				root_dir = vim.fs.root(args.buf, { "package.json", ".git" }),
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	})
end

-- Java
-- Install: brew install jdtls (macOS) or download from https://github.com/eclipse/eclipse.jdt.ls
if vim.fn.executable("jdtls") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "java",
		callback = function(args)
			vim.lsp.start({
				name = "jdtls",
				cmd = { "jdtls" },
				root_dir = vim.fs.root(args.buf, { "pom.xml", "build.gradle", ".git" }),
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	})
end

-- Diagnostic display settings with borders
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- Commands (lines 138, 141, 144 from coc.vim)
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = true })
end, {})

-- Note: CocList commands (lines 153-167) are now replaced by Telescope
-- :Telescope diagnostics (replaces CocList diagnostics)
-- :Telescope lsp_document_symbols (replaces CocList outline)
-- :Telescope lsp_workspace_symbols (replaces CocList symbols)
