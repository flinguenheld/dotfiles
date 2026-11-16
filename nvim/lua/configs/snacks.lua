-- snacks.nvim: one plugin, many modules; only the ones enabled here are used
-- Their shortcuts (pickers, lazygit, toggles, words…) are in lua/mappings.lua
-- See all modules and options: https://github.com/folke/snacks.nvim
-- ─────────────────────────────────────────────────────────────────────────────

local options = {
  bigfile = { enabled = true }, -- turn off heavy features on very large files
  dashboard = { enabled = true }, -- start screen (recent files, projects, keys)
  dim = { enabled = true }, -- dim code outside the current scope (<space>uD)
  explorer = { enabled = true }, -- file tree built on the picker (<space>e)
  image = { enabled = true }, -- show images (markdown, picker preview) in WezTerm
  input = { enabled = true }, -- nicer popup when Neovim asks for text
  lazygit = { enabled = true }, -- lazygit in a floating window
  notifier = { enabled = true }, -- notifications as popups + history (<space>sn)
  picker = { enabled = true }, -- fuzzy picker (files, grep, LSP…)
  quickfile = { enabled = true }, -- show the file faster on `nvim file`
  scope = { enabled = true }, -- ii / ai text objects, [i / ]i jumps
  statuscolumn = { enabled = true }, -- signs left (diagnostics, marks), git right
  toggle = { enabled = true }, -- on/off switches shown in which-key (<space>u…)
  words = { enabled = true }, -- highlight LSP references, ]r / [r to jump
}

return options
