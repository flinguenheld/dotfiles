-- Language servers (LSP): settings and the list of servers to start
-- Install the servers with Mason (configs/mason.lua) or your system
-- Check which servers are attached with :checkhealth vim.lsp
-- ─────────────────────────────────────────────────────────────────────────────

-- NvChad's LSP setup (shortcuts, diagnostics, completion, lua_ls)
require("nvchad.configs.lspconfig").defaults()

-- Turn off NvChad's buffer LSP keys (gd, gD, <space>D, <space>ra, <space>w…)
-- Our LSP keys are in mappings.lua
require("nvchad.configs.lspconfig").on_attach = function() end

-- Diagnostics like Helix: message at the end of other lines,
-- full message under the cursor line
vim.diagnostic.config {
  virtual_text = { prefix = "", current_line = false },
  virtual_lines = { current_line = true },
}

-- Server settings: read :h vim.lsp.config for the available options

-- ──────────────────────────────────────────────────────────────────── Lua ────
-- Mason: lua-language-server, stylua | lua_ls is already enabled by NvChad
-- library: code the server reads to know the API of Neovim and plugins
-- (NvChad's list repeated, + snacks)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          vim.fn.stdpath "data" .. "/lazy/snacks.nvim/lua",
          "${3rd}/luv/library",
        },
      },
    },
  },
})

-- ─────────────────────────────────────────────────────────────────── Rust ────
-- Mason: rust-analyzer | rustup: rustfmt, clippy
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
    },
  },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- Servers to start (lspconfig names, see :h lspconfig-all)
local servers = {
  "cssls",
  "html",
  "rust_analyzer",
}
vim.lsp.enable(servers)
