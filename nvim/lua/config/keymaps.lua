-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Window --------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<C-left>", "<C-w>h", opts)
vim.keymap.set("n", "<C-down>", "<C-w>j", opts)
vim.keymap.set("n", "<C-up>", "<C-w>k", opts)
vim.keymap.set("n", "<C-right>", "<C-w>l", opts)

vim.keymap.set("n", "<S-left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<S-down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<S-up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<S-right>", ":vertical resize +2<CR>", opts)

-- Miscellaneous -------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>*", ":noh<CR>", { noremap = true, silent = true, desc = "noh" })

-- Clipboard -----------------------------------------------------------------------------------------------------
vim.keymap.set("", "<C-y>", '"+y', { noremap = true, silent = true, desc = "Copy nvim to the desk clipboard" })
vim.keymap.set("v", "<leader>y", '"zy<CR>', { noremap = true, silent = true, desc = "Copy into the 'z' register" })
vim.keymap.set("v", "<leader>D", '"zd<CR>', { noremap = true, silent = true, desc = "Delete into the 'z' register" })
vim.keymap.set("n", "<leader>p", '"zp', { noremap = true, silent = true, desc = "Copy from the 'z' register" })
