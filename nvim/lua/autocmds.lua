-- Autocommands: code that runs on events (save, filetype…)
-- Loaded from init.lua after the plugins
-- See :h autocmd-events for the list of events
-- ─────────────────────────────────────────────────────────────────────────────

local autocmd = vim.api.nvim_create_autocmd

-- Before saving: remove spaces at line ends and empty lines at the end of the file
-- (like Helix trim-trailing-whitespace + trim-final-newlines; formatters often do it too)
autocmd("BufWritePre", {
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.cmd [[keeppatterns %s/\n\+\%$//e]]
    vim.fn.winrestview(view)
  end,
})

-- Don't continue comments on the next line (Enter in Insert mode, o / O), like Helix continue-comments = false
-- Done on FileType because each file type sets its own formatoptions
autocmd("FileType", {
  callback = function() vim.opt_local.formatoptions:remove { "r", "o" } end,
})
