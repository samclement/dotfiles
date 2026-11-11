-- Guarded: a missing plugin (fresh machine, or before packer finished
-- installing) should not error at startup.
local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then return end

catppuccin.setup({
    disable_background = true
})

function ColorMyPencils(color) 
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyPencils()
