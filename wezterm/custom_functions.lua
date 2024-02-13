local wezterm = require 'wezterm'

-- This is the module table that we will export
local module = {}


-- ----------------------------------------------------------------------------
-- ------------------------------------------------------------------ Theme ---
function up_theme(window)
  local overrides = window:get_config_overrides() or {}

  local scheme = 'Catppuccin Mocha'
  if next(overrides) ~= nil then
    if overrides.color_scheme:find 'Latte' then
      scheme = 'Catppuccin Frappe'
    elseif overrides.color_scheme:find 'Frappe' then
      scheme = 'Catppuccin Macchiato'
    elseif overrides.color_scheme:find 'Macchiato' then
      scheme = 'Catppuccin Mocha'
    elseif overrides.color_scheme:find 'Mocha' then
      scheme = 'Catppuccin Latte'
    end
  end

  wezterm.log_info('Update theme: ', scheme)

  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end

-- ----------------------------------------------------------------------------
-- ------------------------------------------------------------------ ##### ---

-- return our module table
return module
