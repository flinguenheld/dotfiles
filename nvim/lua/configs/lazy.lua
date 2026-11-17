-- lazy.nvim settings, passed to require("lazy").setup() in init.lua
-- Disables built-in Vim plugins this config doesn't use, for a faster startup
-- Open the plugin manager with :Lazy
-- ─────────────────────────────────────────────────────────────────────────────

return {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
