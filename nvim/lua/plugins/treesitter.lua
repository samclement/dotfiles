-- Treesitter configuration for better syntax highlighting

require("nvim-treesitter.configs").setup({
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to install (or "all")
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"javascript",
		"typescript",
		"tsx",
		"json",
		"html",
		"css",
		"python",
		"rust",
		"go",
		"bash",
		"markdown",
		"markdown_inline",
		"yaml",
		"toml",
	},

	-- Highlighting
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	-- Indentation based on treesitter
	indent = {
		enable = true,
	},

	-- Incremental selection
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			scope_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
})
