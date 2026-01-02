-- nvim-tree file explorer (replaces NERDTree)

-- Custom keymaps to match NERDTree behavior
local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	-- Default mappings
	api.config.mappings.default_on_attach(bufnr)

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
end

require("nvim-tree").setup({
	-- Disable netrw
	disable_netrw = true,
	hijack_netrw = true,

	-- Show hidden files (NERDTreeShowHidden=1)
	filters = {
		dotfiles = false,
	},

	-- Window position (g:NERDTreeWinPos = "right")
	view = {
		side = "right",
		width = 30,
	},

	-- Use custom keymaps
	on_attach = on_attach,

	-- Git integration (nerdtree-git-plugin)
	git = {
		enable = true,
		ignore = false,
	},

	-- Icons (vim-devicons replacement)
	renderer = {
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				folder = {
					arrow_closed = "▹", -- g:NERDTreeDirArrowExpandable
					arrow_open = "▿", -- g:NERDTreeDirArrowCollapsible
				},
			},
		},
	},

	-- Actions
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
})

-- Keymaps (from nerdtree.vim)
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Toggle nvim-tree or find current file (<leader>n)
keymap("n", "<leader>n", function()
	local api = require("nvim-tree.api")
	if api.tree.is_visible() then
		api.tree.close()
	else
		-- Open tree and find current file if one is open
		if vim.fn.expand("%") == "" or vim.bo.filetype == "" then
			api.tree.open()
		else
			api.tree.open({ find_file = true })
		end
	end
end, opts)

-- Find current file in tree (<leader>N)
keymap("n", "<leader>N", function()
	require("nvim-tree.api").tree.open({ find_file = true })
end, opts)
