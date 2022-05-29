-- LSPINSTALLER −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
require("nvim-lsp-installer").setup({
    ensure_installed = { "rust_analyzer", "sumneko_lua", 'pylsp' }, -- ensure these servers are always installed
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
