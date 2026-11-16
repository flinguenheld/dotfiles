-- Formatters per file type (conform.nvim)
-- Formats on save (event set in plugins/init.lua), or by hand with <space>cf
-- Install the formatters with Mason (configs/mason.lua) or your system
-- ─────────────────────────────────────────────────────────────────────────────

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return options
