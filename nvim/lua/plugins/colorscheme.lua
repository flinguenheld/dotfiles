-- The line below is changed by ~/.config/theme/theme_menu (sed), keep it as is
local theme = "catppuccin_frappe"

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Theme name from theme_menu → Neovim colorscheme and background
-- (everforest and gruvbox pick their dark or light variant from the background)
local THEMES = {
  everforest_dark = { "everforest", "dark" },
  everforest_light = { "everforest", "light" },
  gruvbox = { "gruvbox", "dark" },
  gruvbox_light = { "gruvbox", "light" },
  ayu_mirage = { "ayu-mirage", "dark" },
  ayu_light = { "ayu-light", "light" },
  catppuccin_frappe = { "catppuccin-frappe", "dark" },
  catppuccin_latte = { "catppuccin-latte", "light" },
  catppuccin_macchiato = { "catppuccin-macchiato", "dark" },
  catppuccin_mocha = { "catppuccin-mocha", "dark" },
}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- This file's path: read_theme() reads it again to find the new theme line
-- (stdpath("config") is ~/.config/nvim)
local THIS_FILE = vim.fn.stdpath("config") .. "/lua/plugins/colorscheme.lua"

-- Apply a theme name from the table above, e.g. apply("gruvbox_light")
-- Background first: everforest and gruvbox read it while loading
-- Unknown name: raises an error, the caller decides what to do with it
local function apply(name)
  local choice = THEMES[name]
  if not choice then
    error("unknown theme: " .. tostring(name))
  end
  vim.o.background = choice[2]
  vim.cmd.colorscheme(choice[1])
end

-- Return the theme name written in this file right now
-- The `theme` variable can't be used: it keeps the value read at startup,
-- while theme_menu may have changed the line since
local function read_theme()
  for line in io.lines(THIS_FILE) do
    -- same pattern as theme_menu's sed, (.-) captures the name
    local name = line:match('^local theme = "(.-)"')
    if name then
      return name
    end
  end
end

-- Called on SIGUSR1: apply the theme theme_menu just wrote in this file
-- pcall: catch apply's error and show it, Neovim keeps its theme
local function on_signal()
  local ok, err = pcall(apply, read_theme())
  if not ok then
    vim.notify(err, vim.log.levels.WARN)
  end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
return {
  {
    "sainnhe/everforest",
    lazy = true, -- loaded on demand when the colorscheme is applied
    init = function()
      -- these must be set *before* the theme loads
      vim.g.everforest_background = "medium" -- "hard", "medium" or "soft"
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_better_performance = 1
    end,
  },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "Shatur/neovim-ayu", lazy = true },
  -- catppuccin: already installed by LazyVim, nothing to add

  -- LazyVim accepts a function instead of a theme name, it calls it once at
  -- startup: a good place to apply the theme and set up the live switch
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- Live switch: theme_menu sends SIGUSR1 (pkill -USR1 nvim), like Helix
        -- An autocommand runs a function when an event happens, here a signal
        vim.api.nvim_create_autocmd("Signal", {
          -- group with clear: created twice, it's replaced, not duplicated
          group = vim.api.nvim_create_augroup("theme_menu", { clear = true }),
          pattern = "SIGUSR1",
          -- nested: let the theme change fire its own events, lazy.nvim
          -- loads the theme plugin on one of them, lualine redraws on another
          nested = true,
          callback = on_signal,
        })
        -- unknown name: LazyVim catches the error and falls back to habamax
        apply(theme)
      end,
    },
  },
}
