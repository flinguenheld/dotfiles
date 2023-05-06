-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = "unnamed"
vim.opt.colorcolumn = "115"

-- Disable comment continuation
vim.cmd([[autocmd FileType * setlocal formatoptions=cqrnj]])
