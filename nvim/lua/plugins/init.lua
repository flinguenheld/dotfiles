-- Plugin list for lazy.nvim, on top of the plugins NvChad already ships
-- Each entry: plugin name, when to load it, and its options
-- Long options live in lua/configs/<name>.lua
-- ─────────────────────────────────────────────────────────────────────────────

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false, -- must load before VimEnter to install at startup
    dependencies = { "mason-org/mason.nvim" },
    opts = require "configs.mason",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  {
    "folke/snacks.nvim",
    lazy = false, -- snacks loads its modules on first use by itself
    priority = 1000,
    opts = require "configs.snacks",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "snacks") -- theme colours
      require("snacks").setup(opts)
    end,
  },

  {
    "folke/which-key.nvim",
    opts = require "configs.whichkey",
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy", -- loaded right after startup (f/t need it ready)
    opts = require "configs.flash",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "flash") -- theme colours
      require("flash").setup(opts)
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = require "configs.todo",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "todo") -- theme colours
      require("todo-comments").setup(opts)
    end,
  },

  -- Replaced by snacks (picker, explorer)
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-tree/nvim-tree.lua", enabled = false },
}
