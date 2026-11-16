-- Autocommands: code that runs on events (save, open file, filetype…)
-- Loads NvChad's autocmds first, add yours below
-- See :h autocmd-events for the list of events
-- ─────────────────────────────────────────────────────────────────────────────

require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- ──────────────────────────────────────────────────────── From Helix ────

-- Before saving: remove spaces at line ends and empty lines at the end of file
autocmd("BufWritePre", {
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.cmd [[keeppatterns %s/\n\+\%$//e]]
    vim.fn.winrestview(view)
  end,
})

-- Don't continue comments on the next line (Enter in insert mode, o / O)
-- Done on FileType because each file type sets its own formatoptions
autocmd("FileType", {
  callback = function() vim.opt_local.formatoptions:remove { "r", "o" } end,
})
