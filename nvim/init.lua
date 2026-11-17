-- Entry point: Neovim loads this file first
-- Sets the leader key and the options, installs lazy.nvim (plugin manager) on the
-- first start, then loads the plugins with the settings from lua/configs/lazy.lua
-- ─────────────────────────────────────────────────────────────────────────────

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "options"

-- bootstrap: clone lazy.nvim if it's missing, then add it to the runtimepath
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- load plugins: every file in lua/plugins/ returns plugin specs
require("lazy").setup({ { import = "plugins" } }, require "configs.lazy")

require "autocmds"
require "mappings"
