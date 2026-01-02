-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Spell-check for Markdown and Git commits
local spell_group = augroup("SpellCheck", { clear = true })
autocmd("FileType", {
	group = spell_group,
	pattern = { "markdown", "gitcommit" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.complete:append("kspell")
	end,
})
