-- Colour scheme: the theme picked with ~/.config/theme/theme_menu, read from palette.toml
-- Applied at startup, and again when theme_menu sends SIGUSR1 (pkill -USR1 nvim)
-- Missing file or unknown name (e.g. Serika): warning + default theme; scheme fails: warning, theme kept
-- ─────────────────────────────────────────────────────────────────────────────

local palette_path = vim.fs.normalize "~/.config/theme/palette.toml"
local default = "catppuccin_frappe"
local themes = {
  ayu_light = { "ayu-light", "light" },
  ayu_mirage = { "ayu-mirage", "dark" },
  catppuccin_frappe = { "catppuccin-frappe", "dark" },
  catppuccin_latte = { "catppuccin-latte", "light" },
  catppuccin_macchiato = { "catppuccin-macchiato", "dark" },
  catppuccin_mocha = { "catppuccin-mocha", "dark" },
  everforest_dark = { "everforest", "dark" },
  everforest_light = { "everforest", "light" },
  gruvbox = { "gruvbox", "dark" },
  gruvbox_light = { "gruvbox", "light" },
}

-- ─────────────────────────────────────────────────────────────────────────────
-- ────────────────────────────────────────────────────────────────── WARN ─────
local function warn(message) vim.notify(message, vim.log.levels.WARN) end

-- ─────────────────────────────────────────────────────────────────────────────
-- ──────────────────────────────── GET THEME ~/.config/theme/palette.toml ─────
local function get_theme()
  if vim.fn.filereadable(palette_path) == 0 then
    warn(palette_path .. " not found: using the default theme " .. default)
    return default
  end

  for _, line in ipairs(vim.fn.readfile(palette_path)) do
    local name = line:match '^theme%s*=%s*"(.-)"'
    if name and themes[name] then return name end
    if name then
      warn("Theme " .. name .. " doesn't exist in Neovim: using the default theme " .. default)
      return default
    end
  end

  warn('No theme="…" line in ' .. palette_path .. ": using the default theme " .. default)
  return default
end

-- ─────────────────────────────────────────────────────────────────────────────
-- ───────────────────────────────────────────────────────────────── APPLY ─────
-- Apply a theme name from get_theme() (always in the themes table): set the background,
-- then load the colour scheme
local function apply(name)
  local scheme = themes[name]
  local background = vim.o.background
  vim.o.background = scheme[2]
  local ok, err = pcall(vim.cmd.colorscheme, scheme[1])
  if not ok then
    vim.o.background = background
    warn("Colour scheme " .. scheme[1] .. " failed to load: current theme kept\n" .. err)
  end
end

-- ─────────────────────────────────────────────────────────────────────────────
-- ─────────────────────────────────────────────────────────────── AUTOCMD ─────
-- clear = true: lazy.nvim reads this file again when it changes, so the
-- autocommands would otherwise be added twice
-- nested = true: :colorscheme must fire its own events (ColorSchemePre loads the theme's
-- plugin, ColorScheme updates lualine and bufferline); autocommands don't do that by default
local group = vim.api.nvim_create_augroup("theme", { clear = true })

-- ───────────────────────────────────────────────
-- ───────────────────────────────────── STARTUP ─────
-- At startup, once lazy.nvim knows the plugins (it loads the theme's plugin on :colorscheme)
vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "LazyDone",
  once = true,
  nested = true,
  callback = function() apply(get_theme()) end,
})

-- ───────────────────────────────────────────────
-- ────────────────────────────────────── SIGNAL ─────
-- theme_menu wrote a new palette.toml and sent SIGUSR1
vim.api.nvim_create_autocmd("Signal", {
  group = group,
  pattern = "SIGUSR1",
  nested = true,
  callback = function() apply(get_theme()) end,
})

-- ─────────────────────────────────────────────────────────────────────────────
-- ─────────────────────────────────────────────────────────────────────────────
-- The four theme families, loaded only when their colour scheme is used
return {
  { "Shatur/neovim-ayu", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true, opts = { auto_integrations = true } },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "sainnhe/everforest", lazy = true },
}
