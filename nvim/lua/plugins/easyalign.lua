-- Easy align for text alignment

local keymap = vim.keymap.set

-- Interactive EasyAlign in visual mode (e.g., vipga)
keymap("x", "ga", "<Plug>(EasyAlign)", {})

-- Interactive EasyAlign for motion/text object (e.g., gaip)
keymap("n", "ga", "<Plug>(EasyAlign)", {})
