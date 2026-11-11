-- Bootstrap packer on a fresh machine, then load it.
-- A new machine has no packer and therefore no way to install plugins, and
-- an offline machine must still start: every failure below degrades to a
-- notification instead of aborting init.lua.
local fn = vim.fn
local data_dir = fn.stdpath('data')
local packer_dir = data_dir .. '/site/pack/packer/start/packer.nvim'

local function installed()
	-- vim.fn.empty() returns a number; Lua treats 0 as truthy, so compare.
	return fn.empty(fn.glob(packer_dir)) == 0
end

local function unavailable(reason)
	vim.schedule(function()
		vim.notify('packer.nvim unavailable: ' .. reason .. '; run ./bootstrap', vim.log.levels.ERROR)
	end)
end

if not installed() then
	if fn.executable('git') == 0 then
		unavailable('git not found')
		return
	end
	fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_dir })
	if not installed() then
		unavailable('clone failed')
		return
	end
end

-- packadd throws E919 when the directory is missing, which would abort
-- init.lua; catch it so the rest of the config still loads.
if not pcall(vim.cmd, 'packadd packer.nvim') then
	unavailable('packadd failed')
	return
end

local ok, packer = pcall(require, 'packer')
if not ok then
	unavailable('module did not load')
	return
end

if vim.islist then
	vim.tbl_islist = vim.islist
end

local startup = packer.startup(function(use)
	use('wbthomason/packer.nvim')

	use({"catppuccin/nvim", as = "catppuccin"})
	use({
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		requires = { { 'nvim-lua/plenary.nvim' } },
	})

	-- A string hook is run with vim.cmd() and no pcall, so on a fresh install
	-- ':TSUpdate' throws E492 (the command is not defined yet) and aborts the
	-- whole install coroutine. Guard it; parsers also self-install via
	-- auto_install in after/plugin/treesitter.lua.
	use({
		'nvim-treesitter/nvim-treesitter',
		branch = 'master',
		run = function()
			if vim.fn.exists(':TSUpdate') == 2 then
				vim.cmd('TSUpdate')
			end
		end,
	})
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

-- Install anything missing: a plugin added to the spec above and pulled on
-- another machine, or a brand new machine. packer checks the filesystem and
-- returns immediately ("All configured plugins are installed") when there is
-- nothing to do, so this costs no network on a normal start.
-- Skipped in headless runs so ./bootstrap's PackerSync stays authoritative.
if #vim.api.nvim_list_uis() > 0 then
	local function plugin_count()
		return #fn.glob(data_dir .. '/site/pack/packer/start/*', false, true)
	end

	local before = plugin_count()
	vim.api.nvim_create_autocmd('User', {
		pattern = 'PackerComplete',
		once = true,
		callback = function()
			if plugin_count() > before then
				vim.notify('Packer installed new plugin(s); restart nvim to load them', vim.log.levels.WARN)
			end
		end,
	})

	vim.schedule(function()
		pcall(vim.cmd, 'PackerInstall')
	end)
end

return startup
