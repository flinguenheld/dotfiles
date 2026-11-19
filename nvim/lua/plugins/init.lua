-- Plugin list (lazy.nvim specs); their settings are in lua/configs/
-- Themes are in plugins/colorscheme.lua; open the plugin manager with :Lazy
-- One entry per plugin, in alphabetical order of the repository name
-- ─────────────────────────────────────────────────────────────────────────────

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy", -- right after startup (the bar only shows with 2+ buffers anyway)
    opts = require "configs.bufferline",
  },

  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" }, -- when a file opens
    opts = require "configs.highlightcolors",
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy", -- loaded right after startup (f / t need it ready)
    opts = require "configs.flash",
  },

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
    "folke/todo-comments.nvim",
    event = "VeryLazy", -- right after startup: its snacks picker (<space>t) must exist before any file opens
    opts = require "configs.todo",
    -- no plenary.nvim: only todo-comments' own :TodoQuickFix / :TodoLocList / :TodoTelescope need it
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- loaded right after startup
    opts = require "configs.whichkey",
  },

  {
    "gbprod/yanky.nvim",
    event = "VeryLazy", -- right after startup: its <Plug> keys (p, P, Ctrl-p…) must exist before the first paste
    opts = require "configs.yanky",
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    -- Its own keys (ys, cs, ds, Visual S, Insert Ctrl-g s…) are set when it loads: all off,
    -- the Helix-style m keys are in mappings.lua
    init = function() vim.g.nvim_surround_no_mappings = true end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- when a file opens
    opts = {}, -- defaults: signs on (shown by snacks statuscolumn), line blame off (<space>ub)
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar", -- also loaded by <space>r (mappings.lua)
    opts = {
      -- Its window keys start with <space> (local leader): <space>r replace, <space>s sync, <space>q close, g? help
      keymaps = {
        close = { n = "<localleader>q" }, -- was <space>c (q like <space>bq)
        qflist = { n = "<localleader>Q" }, -- was <space>q
        openNextLocation = false, -- was ↓: the arrows only move the cursor (hjkl are off)
        openPrevLocation = false, -- was ↑
      },
    },
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
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- right after startup
    init = function() vim.o.statusline = " " end, -- empty bar until lualine loads (not Neovim's own for a moment)
    opts = require "configs.lualine",
  },

  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = function() return require "configs.miniai" end, -- a function: the file needs mini.ai loaded
  },

  {
    "nvim-mini/mini.icons",
    lazy = false, -- small, and bufferline (step 20) asks for nvim-web-devicons at startup
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
    "saghen/blink.cmp",
    version = "1.*", -- release versions download the ready-made Rust fuzzy matcher (no compiling)
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = require "configs.blink",
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    cmd = "ConformInfo",
    opts = require "configs.conform",
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Treesitter: no pairing inside strings and comments
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false, -- must load before VimEnter to install at startup
    dependencies = { "mason-org/mason.nvim" },
    opts = require "configs.mason",
  },
}
