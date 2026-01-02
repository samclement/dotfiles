-- General settings
local opt = vim.opt

-- Enable syntax highlighting (required for treesitter)
vim.cmd("syntax enable")

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.hidden = true
opt.signcolumn = "no"  -- Overridden from yes:2 based on line 37
opt.relativenumber = true
opt.number = true
opt.termguicolors = true
opt.undofile = true
opt.title = true
opt.ignorecase = true
opt.smartcase = true
opt.wildmode = "longest:full,full"
opt.wrap = true
opt.linebreak = true
opt.list = true
opt.listchars = { tab = "▸ ", trail = "·" }
opt.mouse = "a"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.joinspaces = false
opt.splitright = true
opt.clipboard = "unnamedplus"
opt.confirm = true
opt.exrc = true
opt.backup = true
opt.backupdir = vim.fn.expand("~/.local/share/nvim/backup//")
opt.updatetime = 300
opt.redrawtime = 10000
opt.foldcolumn = "1"
opt.showtabline = 0
opt.showmode = false
opt.cmdheight = 1
opt.shortmess:append("c")
