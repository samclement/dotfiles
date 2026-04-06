vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local opts = { noremap = true, silent = true }

-- utils
local function is_quickfix_window()
	local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
	return wininfo and wininfo.quickfix == 1
end

local function is_location_list_window()
	local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
	return wininfo and wininfo.loclist == 1
end

-- navigation
vim.keymap.set("n", "<C-j>", function()
	if is_location_list_window() then
		vim.cmd.lprev()
	elseif is_quickfix_window() then
		vim.cmd.cprev()
	else
		vim.cmd.wincmd("j")
	end
end, opts)

vim.keymap.set("n", "<C-k>", function()
	if is_location_list_window() then
		vim.cmd.lnext()
	elseif is_quickfix_window() then
		vim.cmd.cnext()
	else
		vim.cmd.wincmd("k")
	end
end, opts)

vim.keymap.set("n", "<C-h>", "<C-W>h", opts)
vim.keymap.set("n", "<C-l>", "<C-W>l", opts)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/samclement/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
