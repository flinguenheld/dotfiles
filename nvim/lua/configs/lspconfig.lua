-- Language servers (LSP): diagnostics style, server settings and the list of servers to start
-- Install the servers with Mason (configs/mason.lua) or your system; the LSP keys are in mappings.lua
-- Check which servers are attached with :checkhealth vim.lsp
-- ─────────────────────────────────────────────────────────────────────────────

local severity = vim.diagnostic.severity

-- Diagnostics like Helix: message at the end of other lines, full message under the cursor line
vim.diagnostic.config {
  severity_sort = true, -- errors first (signs, popups)
  virtual_text = { prefix = "", current_line = false },
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [severity.ERROR] = "",
      [severity.WARN] = "",
      [severity.INFO] = "",
      [severity.HINT] = "",
    },
  },
}

-- Server settings: read :h vim.lsp.config for the available options
-- Command, file types and project root come from nvim-lspconfig (:h lspconfig-all)

-- ──────────────────────────────────────────────────────────────────── Lua ────
-- Mason: lua-language-server, stylua
-- lazydev (plugins/init.lua) tells lua_ls about Neovim, this config and the plugins

-- ─────────────────────────────────────────────────────────────────── Rust ────
-- Mason: rust-analyzer | rustup: rustfmt, clippy

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" }, -- lints on save, not just compiler errors
    },
  },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- Servers to start (lspconfig names), in alphabetical order

vim.lsp.enable {
  "lua_ls",
  "rust_analyzer",
}
