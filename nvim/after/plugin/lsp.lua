local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

pcall(require('luasnip.loaders.from_vscode').lazy_load)

local function confirm_completion(fallback)
	if cmp.visible() then
		cmp.confirm({ select = true })
	else
		fallback()
	end
end

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping(confirm_completion, { 'i', 's' }),
		['<Tab>'] = cmp.mapping(confirm_completion, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'nvim_lua' },
		{ name = 'path' },
	}, {
		{ name = 'buffer' },
	}),
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('samclement-lsp-attach', { clear = true }),
	callback = function(event)
		local opts = { buffer = event.buf, remap = false }

		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '[d', function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
		vim.keymap.set('n', ']d', function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
		vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
		vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
	end,
})

vim.lsp.config('*', {
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
		},
	},
})

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		'ts_ls',
		'rust_analyzer',
		'lua_ls',
	},
	automatic_enable = true,
})

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = 'E',
			[vim.diagnostic.severity.WARN] = 'W',
			[vim.diagnostic.severity.HINT] = 'H',
			[vim.diagnostic.severity.INFO] = 'I',
		},
	},
})
