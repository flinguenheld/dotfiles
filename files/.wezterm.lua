-- Folder : /home/

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 100
config.initial_rows = 50

-- or, changing the font size and color scheme.
config.font_size = 11
-- config.font = wezterm.font 'Hack Nerd Font'
config.color_scheme = 'Catppuccin Frappe'

--  ---------------------------------------------------------------------------
--  ---------------------------------------------------------------- WINDOW ---
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"
config.window_padding = {
  left   = 0,
  right  = 0,
  top    = 0,
  bottom = 0,
}

--  ---------------------------------------------------------------------------
--  -------------------------------------------------------------- KEYBINDS ---
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'w', mods = 'SUPER', timeout_milliseconds = 3000 }
config.keys = {

  {
    key = 'Return',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.SpawnWindow,
  },
  {
    key = 'r',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ReloadConfiguration,
  },
--  ----------------------------------------------
--  ------------------------------------ PANES ---
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.RotatePanes 'Clockwise',
  },
  {
    key = 'q',
    mods = 'LEADER|CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.PaneSelect { alphabet = 'asenrtiu', },
  },

  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.Nop, },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.Nop, },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.Nop, },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.Nop, },
  
  { key = 'LeftArrow',  mods = 'SUPER|ALT', action = wezterm.action.ActivatePaneDirection 'Left',  },
  { key = 'RightArrow', mods = 'SUPER|ALT', action = wezterm.action.ActivatePaneDirection 'Right', },
  { key = 'UpArrow',    mods = 'SUPER|ALT', action = wezterm.action.ActivatePaneDirection 'Up',    },
  { key = 'DownArrow',  mods = 'SUPER|ALT', action = wezterm.action.ActivatePaneDirection 'Down',  },
--  ----------------------------------------------
--  -------------------------------- FONT SIZE ---
  {
    key = '=',
    mods = 'LEADER',
    action = wezterm.action.ResetFontSize
  },
  {
    key = '+',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.IncreaseFontSize
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.DecreaseFontSize
  },
--  ----------------------------------------------
--  ------------------------------------- TABS ---
  {
    key = 't',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },

  { key = '1', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '2', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '3', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '4', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '5', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '6', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '7', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '8', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '9', mods = 'SUPER', action = wezterm.action.Nop },
  { key = '0', mods = 'SUPER', action = wezterm.action.Nop },

  { key = '1', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(8) },
  { key = '0', mods = 'SUPER|ALT', action = wezterm.action.ActivateTab(9) },
}

-- Finally, return the configuration to wezterm:
return config
