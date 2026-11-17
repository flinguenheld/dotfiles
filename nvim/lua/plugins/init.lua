-- Plugin list (lazy.nvim specs); their settings are in lua/configs/
-- Themes are in plugins/colorscheme.lua; open the plugin manager with :Lazy
-- One entry per plugin, in alphabetical order of the repository name
-- ─────────────────────────────────────────────────────────────────────────────

return {
  {
    "folke/snacks.nvim",
    lazy = false, -- snacks loads its modules on first use by itself
    priority = 1000, -- set up before the other plugins (it replaces vim.notify, vim.ui.input…)
    opts = require "configs.snacks",
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- loaded right after startup
    opts = require "configs.whichkey",
  },

  {
    "nvim-mini/mini.icons",
    lazy = false, -- small, and bufferline (step 19) asks for nvim-web-devicons at startup
    opts = {
      style = "glyph", -- Nerd Font icons (WezTerm ships the symbols as a fallback font)
      -- style = "ascii", -- letters instead of icons
    },
    config = function(_, opts)
      require("mini.icons").setup(opts)
      MiniIcons.mock_nvim_web_devicons() -- plugins asking for nvim-web-devicons get mini.icons
    end,
  },
}
