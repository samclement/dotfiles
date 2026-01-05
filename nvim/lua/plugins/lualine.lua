-- lualine statusline (replaces vim-airline)

require("lualine").setup({
	options = {
		theme = "dracula", -- g:airline_theme = 'dracula'
		icons_enabled = true, -- g:airline_powerline_fonts = 1
		component_separators = { left = "", right = "" }, -- g:airline_left_sep, g:airline_right_sep = ''
		section_separators = { left = "", right = "" }, -- Powerline arrows
		globalstatus = true,
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				path = 1, -- Show relative path in inactive windows too
			},
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- Tabline disabled (set showtabline=0 in options)
	tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
			{
				"filename",
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute with ~
				shorting_target = 40, -- Shorten path to fit
				symbols = {
					modified = "[+]",
					readonly = "[-]",
					unnamed = "[No Name]",
				},
			},
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
	extensions = { "fugitive", "nvim-tree" },
})
