-- Autocommands: code that runs on events (save, filetype…)
-- Loaded from init.lua after the plugins
-- See :h autocmd-events for the list of events
-- ─────────────────────────────────────────────────────────────────────────────

local autocmd = vim.api.nvim_create_autocmd

-- Before saving: remove spaces at line ends and empty lines at the end of the file
-- (like Helix trim-trailing-whitespace + trim-final-newlines; formatters often do it too)
autocmd("BufWritePre", {
  callback = function()
    if not vim.bo.modifiable then return end -- e.g. saving :checkhealth output with :w
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

-- Treesitter: highlighting, and indent like Helix, for each file type that has a parser
-- pcall: file types without a parser keep Neovim's regex highlighting
-- Indent only where the language has an indent query; elsewhere Neovim's own indent stays
autocmd("FileType", {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then return end
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if vim.treesitter.query.get(lang, "indents") then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
