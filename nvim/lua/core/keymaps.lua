-- Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = ","

-- General keymaps
keymap("n", "<leader>w", ":w!<cr>", opts)
keymap("n", "<leader>ve", ":edit ~/.config/nvim/init.lua<cr>", opts)
keymap("n", "<leader>vr", ":source ~/.config/nvim/init.lua<cr>", opts)
keymap("n", "<leader>k", ":nohlsearch<CR>", opts)
keymap("n", "<leader>Q", ":bufdo bdelete<cr>", opts)

-- Allow gf to open non-existent files
keymap("n", "gf", ":edit <cfile><cr>", opts)

-- Reselect visual selection after indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Maintain cursor position when yanking
keymap("v", "y", "myy`y", opts)
keymap("v", "Y", "myY`y", opts)

-- Move by terminal rows when wrapped
keymap("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })
keymap("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

-- Paste without copying
keymap("v", "<leader>p", '"_dP', opts)

-- Make Y behave like other capitals
keymap("n", "Y", "y$", opts)

-- Keep it centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- Open file in default program
keymap("n", "<leader>x", ":!xdg-open %<cr><cr>", opts)

-- Quick escape to normal mode
keymap("i", "jj", "<esc>", opts)

-- Easy insertion of trailing ; or ,
keymap("i", ";;", "<Esc>A;<Esc>", opts)
keymap("i", ",,", "<Esc>A,<Esc>", opts)

-- Window navigation
keymap("n", "<C-j>", "<C-W>j", opts)
keymap("n", "<C-k>", "<C-W>k", opts)
keymap("n", "<C-h>", "<C-W>h", opts)
keymap("n", "<C-l>", "<C-W>l", opts)
