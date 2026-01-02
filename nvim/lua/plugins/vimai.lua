-- vim-ai AI assistance

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Complete text
keymap("n", "<leader>a", ":AI<CR>", opts)
keymap("x", "<leader>a", ":AI<CR>", opts)

-- Edit with custom prompt
keymap("x", "<leader>s", ":AIEdit fix grammar and spelling<CR>", opts)
keymap("n", "<leader>s", ":AIEdit fix grammar and spelling<CR>", opts)

-- Trigger chat
keymap("x", "<leader>c", ":AIChat<CR>", opts)
keymap("n", "<leader>c", ":AIChat<CR>", opts)

-- Redo last AI command
keymap("n", "<leader>r", ":AIRedo<CR>", opts)
