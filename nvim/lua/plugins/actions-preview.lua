-- Actions Preview - Code actions with Telescope

local actions_preview = require("actions-preview")

actions_preview.setup({
	-- Use diff mode for preview when available
	diff = {
		algorithm = "patience",
		ignore_whitespace = true,
	},

	-- Telescope configuration
	telescope = {
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			width = 0.8,
			height = 0.9,
			prompt_position = "top",
			preview_cutoff = 20,
			preview_height = function(_, _, max_lines)
				return max_lines - 15
			end,
		},
	},

	-- Fallback to simple select when preview not available
	backend = { "telescope", "nui" },
})
