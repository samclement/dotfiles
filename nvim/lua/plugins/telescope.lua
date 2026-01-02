-- Telescope fuzzy finder

require("telescope").setup({
	defaults = {
		-- Use fd for file finding (faster than find)
		-- Use rg for grepping (faster than grep)
		file_ignore_patterns = {
			"node_modules",
			".git/",
			"%.lock",
		},
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
		-- Use treesitter for better syntax highlighting in preview
		preview = {
			treesitter = true,
		},
	},
	pickers = {
		find_files = {
			-- Use fd if available (install: brew install fd)
			find_command = vim.fn.executable("fd") == 1
					and { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
				or nil,
		},
		live_grep = {
			-- Use ripgrep (install: brew install ripgrep)
			-- Already default, but making it explicit
			additional_args = function()
				return { "--hidden", "--follow", "--glob", "!.git" }
			end,
		},
	},
})

-- Keybindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Original telescope keybindings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- Replace ag.vim (was <leader>g)
keymap("n", "<leader>gr", "<cmd>Telescope live_grep<cr>", opts)

-- Replace bufexplorer (was <leader>o)
keymap("n", "<leader>o", "<cmd>Telescope buffers<cr>", opts)

-- LSP pickers (better than ctags)
keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", opts) -- Find references
keymap("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", opts) -- Document symbols
keymap("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", opts) -- Workspace symbols
keymap("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", opts) -- Definitions
keymap("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", opts) -- Implementations
keymap("n", "<leader>ft", "<cmd>Telescope lsp_type_definitions<cr>", opts) -- Type definitions
keymap("n", "<leader>fD", "<cmd>Telescope diagnostics<cr>", opts) -- Diagnostics
