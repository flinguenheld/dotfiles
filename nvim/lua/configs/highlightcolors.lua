-- nvim-highlight-colors: a coloured square next to colour codes (#ff8800, rgb(), hsl()…), in any file, no LSP needed
-- <space>uc turns the squares on / off (mappings.lua, UI section)
-- blink's menu colours CSS / Tailwind completions by itself (cssls, tailwindcss), nothing to set here for it
-- See all options: https://github.com/brenoprata10/nvim-highlight-colors
-- ─────────────────────────────────────────────────────────────────────────────

return {
  render = "virtual", -- a square next to the code, the code itself unchanged
  -- render = "background", -- the code's background painted in its colour
  -- render = "foreground", -- the code's text drawn in its colour

  virtual_symbol = "■",
  virtual_symbol_position = "inline", -- right after the code (VS Code style)
  -- virtual_symbol_position = "eol", -- at the end of the line (then set virtual_symbol_suffix = "")
  -- virtual_symbol_position = "eow", -- at the end of the word (then prefix = " ", suffix = "")
  virtual_symbol_prefix = "",
  virtual_symbol_suffix = " ",

  -- Formats
  enable_hex = true, -- #ff8800, #ff8800cc
  enable_short_hex = true, -- #f80
  enable_rgb = true, -- rgb(255 136 0), rgba()
  enable_hsl = true, -- hsl(30 100% 50%), hsla()
  enable_hsl_without_function = true, -- CSS: --accent: 30 100% 50%;
  enable_var_usage = true, -- CSS: var(--accent), the colour defined in the same file
  enable_ansi = true, -- terminal escape codes in scripts: \033[0;34m
  enable_xterm256 = true, -- \033[38;5;118m
  enable_xtermTrueColor = true, -- \033[38;2;118;64;90m
  enable_named_colors = false, -- red, blue…: off, any "red" in code or comments would get a square
  enable_tailwind = false, -- bg-red-500: off until web languages come
}
