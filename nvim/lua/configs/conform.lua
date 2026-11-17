-- Formatters per file type (conform.nvim): format on save, or by hand with <space>cf
-- Install the formatters with Mason (configs/mason.lua) or your system; :ConformInfo shows what a file uses
-- <space>uf turns format on save off / on (vim.g.autoformat)
-- ─────────────────────────────────────────────────────────────────────────────

return {
  -- Names from conform's list (:h conform-formatters), in alphabetical order of file type
  formatters_by_ft = {
    lua = { "stylua" }, -- Mason; reads .stylua.toml
    rust = { "rustfmt" }, -- rustup; reads the edition from Cargo.toml
  },

  -- On save, unless turned off with <space>uf
  -- lsp_format = "fallback": a file type without a formatter above uses its language server's formatter
  format_on_save = function()
    if vim.g.autoformat == false then return end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}
