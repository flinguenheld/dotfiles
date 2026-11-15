-- which-key: hide its built-in hjkl labels (disabled in config/keymaps.lua)
-- and show the arrows instead
-- LazyVim adds this spec to its own (opts_extend), nothing is replaced
return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "gk", hidden = true },
      -- Motions popup, after an operator (d, y, c…)
      {
        mode = { "o", "x", "n" },
        { "h", hidden = true },
        { "j", hidden = true },
        { "k", hidden = true },
        { "l", hidden = true },
        { "<Left>", desc = "Left" },
        { "<Down>", desc = "Down" },
        { "<Up>", desc = "Up" },
        { "<Right>", desc = "Right" },
      },
      -- Ctrl-w popup (also <Space>w)
      {
        mode = { "n", "x" },
        { "<C-w>h", hidden = true },
        { "<C-w>j", hidden = true },
        { "<C-w>k", hidden = true },
        { "<C-w>l", hidden = true },
        { "<C-w><Left>", desc = "Go to the left window" },
        { "<C-w><Down>", desc = "Go to the down window" },
        { "<C-w><Up>", desc = "Go to the up window" },
        { "<C-w><Right>", desc = "Go to the right window" },
      },
    },
  },
}
