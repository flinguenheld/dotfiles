-- Mason packages installed automatically at startup (mason-tool-installer), in ~/.local/share/nvim/mason
-- Use Mason names here (see :Mason), e.g. "rust-analyzer", not "rust_analyzer"
-- Commands: :MasonToolsInstall, :MasonToolsUpdate, :MasonToolsClean (removes packages not in this list)
-- ─────────────────────────────────────────────────────────────────────────────

return {
  ensure_installed = {
    "lua-language-server",
    "rust-analyzer", -- Neovim's own copy, comes before rustup's in Neovim's PATH
    "stylua",
  },
}
