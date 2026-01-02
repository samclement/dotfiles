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

-- Auto-detect JSX in .js files
local jsx_group = augroup("JSXDetection", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
	group = jsx_group,
	pattern = "*.js",
	callback = function()
		-- Read first 100 lines to check for JSX
		local lines = vim.api.nvim_buf_get_lines(0, 0, 100, false)
		local content = table.concat(lines, "\n")

		-- Check for JSX patterns:
		-- 1. JSX tags: <Component or <div etc.
		-- 2. return statement with JSX
		-- 3. React imports
		if content:match("<%u") -- <Component (capital letter = React component)
			or content:match("return%s*%(.-<") -- return (...<
			or content:match("return%s+<") -- return <
			or content:match("<%s*>") -- fragments <>
			or content:match("import%s+.-%s+from%s+['\"]react['\"]") -- React import
		then
			vim.bo.filetype = "javascriptreact"
		end
	end,
})

-- Enable treesitter highlighting for supported filetypes
local ts_group = augroup("TreesitterHighlight", { clear = true })
autocmd("FileType", {
	group = ts_group,
	pattern = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"tsx",
		"jsx",
		"html",
		"css",
		"python",
		"go",
		"rust",
		"lua",
		"vim",
		"markdown",
		"json",
	},
	callback = function(args)
		-- Enable treesitter highlighting for this buffer
		local ok = pcall(vim.treesitter.start, args.buf)
		if not ok then
			vim.notify("Treesitter failed to start for " .. vim.bo[args.buf].filetype, vim.log.levels.WARN)
		end
	end,
})
