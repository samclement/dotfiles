-- Bootstrap packer on a fresh machine, then load it. Without the clone,
-- a new machine has no packer and no way to install plugins.
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

vim.cmd([[packadd packer.nvim]])

local ok, packer = pcall(require, 'packer')
if not ok then
	vim.notify('packer.nvim failed to load; run :PackerSync after ./bootstrap', vim.log.levels.ERROR)
	return
end

if vim.islist then
	vim.tbl_islist = vim.islist
end

return packer.startup(function(use)
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
