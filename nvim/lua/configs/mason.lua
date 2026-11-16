-- Mason packages installed automatically at startup (mason-tool-installer)
-- Use Mason names here (see :Mason), e.g. "rust-analyzer", not "rust_analyzer"
-- Commands: :MasonToolsInstall, :MasonToolsUpdate, :MasonToolsClean
-- ─────────────────────────────────────────────────────────────────────────────

local options = {
  ensure_installed = {
    "lua-language-server",
    "rust-analyzer",
    "stylua",
  },
}

return options
