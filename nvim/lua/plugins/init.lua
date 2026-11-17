-- Plugin list (lazy.nvim specs); their settings are in lua/configs/
-- Themes are in plugins/colorscheme.lua; open the plugin manager with :Lazy
-- One entry per plugin, in alphabetical order of the repository name
-- ─────────────────────────────────────────────────────────────────────────────

return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only for Lua files
    opts = {
      library = {
        -- Plugins used through require(…) are found by themselves; these two are used without it
        { path = "${3rd}/luv/library", words = { "vim%.uv" } }, -- vim.uv (libuv bindings)
        { path = "snacks.nvim", words = { "Snacks" } }, -- the Snacks global
      },
    },
  },

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
    "mason-org/mason.nvim",
    lazy = false, -- puts its bin folder in Neovim's PATH before the LSP servers start
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false, -- its lsp/*.lua server descriptions must be in the runtimepath before the first file opens
    config = function() require "configs.lspconfig" end,
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

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- the rewrite for Neovim 0.12 (master is frozen)
    lazy = false, -- the main branch doesn't support lazy-loading
    build = ":TSUpdate", -- update the parsers when the plugin updates
    config = function() require("nvim-treesitter").install(require "configs.treesitter") end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    opts = {
      move = { set_jumps = true }, -- ]f, [t… go into the jump list (Ctrl-o comes back)
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false, -- must load before VimEnter to install at startup
    dependencies = { "mason-org/mason.nvim" },
    opts = require "configs.mason",
  },
}
