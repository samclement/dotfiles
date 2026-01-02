-- Dracula color scheme

-- Custom highlights (from dracula.vim)
vim.cmd([[
  augroup DraculaOverrides
    autocmd!
    autocmd ColorScheme dracula highlight DraculaBoundary guibg=none
    autocmd ColorScheme dracula highlight DraculaDiffDelete ctermbg=none guibg=none
    autocmd ColorScheme dracula highlight DraculaComment cterm=italic gui=italic
  augroup end
]])

-- Set colorscheme
vim.cmd("colorscheme dracula")
