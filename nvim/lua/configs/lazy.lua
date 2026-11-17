-- lazy.nvim settings, passed to require("lazy").setup() in init.lua
-- Disables built-in Vim plugins this config doesn't use, for a faster startup
-- Open the plugin manager with :Lazy
-- ─────────────────────────────────────────────────────────────────────────────

return {
  -- re-read lua/plugins/ when a file there changes, with a "Config Change Detected. Reloading…" message
  change_detection = { notify = true },

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
