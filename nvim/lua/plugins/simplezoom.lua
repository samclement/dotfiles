-- Simple zoom for window management

-- Setup simple-zoom
require("simple-zoom").setup({
	hide_tabline = true,
})

-- Keymap
vim.keymap.set("n", "<leader>z", function()
	require("simple-zoom").toggle_zoom()
end, { noremap = true, silent = true, desc = "Toggle zoom" })
