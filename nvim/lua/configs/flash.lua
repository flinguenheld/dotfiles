-- flash.nvim: jump anywhere on screen with labels (s, S, r, R in mappings.lua)
-- Also enhances f / F / t / T: matches highlighted, repeat f to go to the next
-- See all options: https://github.com/folke/flash.nvim
-- ─────────────────────────────────────────────────────────────────────────────

local options = {
  modes = {
    char = { enabled = true }, -- enhanced f, F, t, T
    search = { enabled = false }, -- no labels in / and ? searches
  },
}

return options
