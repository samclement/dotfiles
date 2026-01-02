-- lualine statusline (replaces vim-airline)

require("lualine").setup({
	options = {
		theme = "dracula", -- g:airline_theme = 'dracula'
		icons_enabled = true, -- g:airline_powerline_fonts = 1
		component_separators = { left = "", right = "" }, -- g:airline_left_sep, g:airline_right_sep
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- Tabline disabled (set showtabline=0 in options)
	tabline = {},
	extensions = { "fugitive", "nvim-tree" },
})
