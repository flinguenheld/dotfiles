-- flash.nvim: jump anywhere on screen with labels (s, S, r, R in mappings.lua)
-- Also enhances f / F / t / T: matches highlighted, press f again to go to the next one
-- See all options: https://github.com/folke/flash.nvim
-- ─────────────────────────────────────────────────────────────────────────────

return {
  modes = {
    char = { enabled = true }, -- enhanced f, F, t, T
    search = { enabled = false }, -- no labels in / and ? searches (Ctrl-s turns them on for one search)
  },
}
