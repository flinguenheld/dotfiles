-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--------------------------------------------------------------------------------
--------------------------------------------------------------------- HJKL -----
-- Arrows only: hjkl moves do nothing (like no_op in Helix)
-- n: normal, x: visual, o: after an operator (dj, yl…)
-- o uses <Esc>: <Nop> would leave the operator waiting for another motion
-- Insert mode isn't touched: the letters still type
for _, key in ipairs({ "h", "j", "k", "l" }) do
  vim.keymap.set({ "n", "x" }, key, "<Nop>")
  vim.keymap.set("o", key, "<Esc>")
  vim.keymap.set("n", "<C-w>" .. key, "<Nop>") -- Ctrl-w + arrows still work
end

-- Remove LazyVim's hjkl shortcuts, their arrow versions are above
-- pcall: no error if a LazyVim update already removed one
local function del(mode, key)
  pcall(vim.keymap.del, mode, key)
end
for _, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<S-h>", "<S-l>" }) do
  del("n", key)
end
for _, mode in ipairs({ "n", "i", "v" }) do
  del(mode, "<A-j>")
  del(mode, "<A-k>")
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Windows: Ctrl + arrows (like Helix), replaces LazyVim's resize (use the mouse)
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window" })

-- Buffers: Alt + Left / Right (like Helix)
vim.keymap.set("n", "<A-Left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<A-Right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

-- Move lines: Alt + Up / Down, LazyVim's Alt-j / Alt-k with arrows
-- (commands copied from LazyVim's own keymaps)
vim.keymap.set("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- LSP popups, on keys freed by the HJKL section
-- remap: run LazyVim's K and gK, which are set per buffer by the LSP
vim.keymap.set("n", "k", "K", { remap = true, desc = "Hover" })
vim.keymap.set("n", "gk", "gK", { remap = true, desc = "Signature Help" })
