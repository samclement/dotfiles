-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

if vim.islist then
	vim.tbl_islist = vim.islist
end

return require('packer').startup(function(use)
	use('wbthomason/packer.nvim')

	use({"catppuccin/nvim", as = "catppuccin"})
	use({
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		requires = { { 'nvim-lua/plenary.nvim' } },
	})

	use({ 'nvim-treesitter/nvim-treesitter', branch = 'master', run = ':TSUpdate' })
	use('nvim-treesitter/playground')

	use('neovim/nvim-lspconfig')
	use('williamboman/mason.nvim')
	use('williamboman/mason-lspconfig.nvim')

	use('hrsh7th/nvim-cmp')
	use('hrsh7th/cmp-buffer')
	use('hrsh7th/cmp-path')
	use('saadparwaiz1/cmp_luasnip')
	use('hrsh7th/cmp-nvim-lsp')
	use('hrsh7th/cmp-nvim-lua')

	use('L3MON4D3/LuaSnip')
	use('rafamadriz/friendly-snippets')

	use('folke/zen-mode.nvim')
	use('tpope/vim-surround')
end)
