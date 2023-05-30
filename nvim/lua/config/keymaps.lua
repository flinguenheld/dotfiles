-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- vim.keymap.set("", "h", "<NOP>", opts)
vim.keymap.set({ "n", "v" }, "l", "<NOP>")
vim.keymap.set({ "n", "v" }, "h", "<NOP>")

-- vim.keymap.set("n", "x", "<NOP>")
-- vim.keymap.set("n", "X", "<NOP>")

-- Window --------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<C-left>", "<C-w>h", opts)
vim.keymap.set("n", "<C-down>", "<C-w>j", opts)
vim.keymap.set("n", "<C-up>", "<C-w>k", opts)
vim.keymap.set("n", "<C-right>", "<C-w>l", opts)

vim.keymap.set("n", "<S-left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<S-down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<S-up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<S-right>", ":vertical resize +2<CR>", opts)

-- Lazy ----------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { noremap = true, silent = true, desc = "Lazy panel" })

-- Tabpages ------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>l", ":tabnext<CR>", { noremap = true, silent = true, desc = "Next tab page" })
vim.keymap.set("n", "<leader>h", ":tabprevious<CR>", { noremap = true, silent = true, desc = "Previous tab page" })

-- Miscellaneous -------------------------------------------------------------------------------------------------
vim.keymap.set({ "i", "n" }, "<esc>", "<esc>") -- Remove the lazy map
vim.keymap.set("n", "<leader>*", ":noh<CR>", { noremap = true, silent = true, desc = "noh" })

-- Clipboard -----------------------------------------------------------------------------------------------------
vim.keymap.set("", "<C-y>", '"+y', { noremap = true, silent = true, desc = "Copy nvim to the desk clipboard" })
vim.keymap.set("v", "<leader>y", '"zy<CR>', { noremap = true, silent = true, desc = "Copy into the 'z' register" })
vim.keymap.set("v", "<leader>D", '"zd<CR>', { noremap = true, silent = true, desc = "Delete into the 'z' register" })
vim.keymap.set("n", "<leader>p", '"zp', { noremap = true, silent = true, desc = "Copy from the 'z' register" })

-- Clangd --------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>o", ":ClangdSwitchSourceHeader<CR>", opts)
-- stylua: ignore

-- Formatter -----------------------------------------------------------------------------------------------------
vim.keymap.set( "n", "<leader>fco", "O// clang-format on<ESC><DOWN>",
  { noremap = true, silent = true, desc = "Add // clang on above" } )
-- stylua: ignore
vim.keymap.set( "n", "<leader>fcf", "o// clang-format off<ESC><UP>",
  { noremap = true, silent = true, desc = "Add // clang off under" } )
-- stylua: ignore
vim.keymap.set( "n", "<leader>flo", "O-- stylua: ignore<ESC><DOWN>",
  { noremap = true, silent = true, desc = "Add -- stylua: ignore" } )
