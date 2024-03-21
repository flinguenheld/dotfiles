-- Pull in the wezterm API
local wezterm = require 'wezterm'
local _ = require 'custom_functions'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Frappe'
-- config.color_scheme = 'Catppuccin Mocha'
-- config.color_scheme = 'Catppuccin Macchiato'
-- config.color_scheme = 'Catppuccin Latte'

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 11.0
-- Deactivate ligatures
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.enable_wayland = false
config.font_size = 17


local act = wezterm.action
config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  -- {
  --   key = 'm',
  --   mods = 'CMD',
  --   action = wezterm.action.DisableDefaultAssignment,
  -- },
  { key = "Enter", mods = "CTRL|SHIFT", action = act.SpawnWindow },

  { key = "h",     mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },
  { key = "d",     mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },

  { key = 'm',     mods = 'CTRL|SHIFT', action = wezterm.action_callback(up_theme), },

  { key = 'n',     mods = 'SHIFT|CTRL', action = act.QuickSelect },
  { key = 'f',     mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 's',     mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },

  { key = "c",     mods = "CTRL|SHIFT", action = act({ CopyTo = "Clipboard" }) },
  { key = "v",     mods = "CTRL|SHIFT", action = act({ PasteFrom = "Clipboard" }) },



}


-- helpers.apply_to_config(config)


-- Bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = { font_size = 10.0, }

-- Window
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Blinking is not recommanded by the doc
config.default_cursor_style = 'BlinkingBlock'
-- config.default_cursor_style = 'SteadyBar'
-- config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 1200



-- and finally, return the configuration to wezterm
return config
