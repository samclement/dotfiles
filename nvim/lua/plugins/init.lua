-- Plugin management with Packer

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer... Close and reopen Neovim.")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand to reload Neovim when plugins/init.lua is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */lua/plugins/init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call to avoid errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Packer popup window style
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Plugin specifications
return packer.startup(function(use)
	-- Packer manages itself
	use("wbthomason/packer.nvim")

	-- Dependencies
	use("nvim-lua/plenary.nvim")

	-- Treesitter for better syntax highlighting
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        local ok, install = pcall(require, "nvim-treesitter.install")
        if ok then install.update({ with_sync = true })() end
      end,
      config = function()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then return end

        configs.setup({
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    })

	-- LSP & Completion (replaces coc.nvim)
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp")
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins.nvim-cmp")
		end,
	})

	-- File Explorer (replaces NERDTree)
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.nvim-tree")
		end,
	})

    -- Snippet engine
    use({
      "L3MON4D3/LuaSnip",
      requires = { "L3MON4D3/jsregexp" },
    })


	-- Statusline (replaces airline)
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.lualine")
		end,
	})

	-- Telescope (already Lua-native, replaces ag.vim and bufexplorer)
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.telescope")
		end,
	})

	-- Color scheme
	use({
		"dracula/vim",
		as = "dracula",
		config = function()
			require("plugins.dracula")
		end,
	})

	-- Git integration
	use("tpope/vim-fugitive")

	-- Tim Pope essentials
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
	use("tpope/vim-unimpaired")

	-- Formatting
	use("sbdchd/neoformat")

	-- Alignment
	use({
		"junegunn/vim-easy-align",
		config = function()
			require("plugins.easyalign")
		end,
	})

	-- AI assistants
	use("github/copilot.vim")
	use({
		"madox2/vim-ai",
		config = function()
			require("plugins.vimai")
		end,
	})
	use({
		"greggh/claude-code.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.claudecode")
		end,
	})

	-- Markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		ft = "markdown",
	})

	-- Window management
	use({
		"fasterius/simple-zoom.nvim",
		config = function()
			require("plugins.simplezoom")
		end,
	})

	-- Automatically set up configuration after cloning packer.nvim
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
