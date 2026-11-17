-- which-key: the popup listing the next keys after <space>, g, Ctrl-w, [, ]…
-- Here: popup style and group names (the shortcuts themselves are in mappings.lua)
-- See all options: https://github.com/folke/which-key.nvim
-- ─────────────────────────────────────────────────────────────────────────────

return {
  -- preset = "classic",
  -- preset = "modern",
  preset = "helix",

  spec = {
    { "<leader>b", group = "buffers" },
    { "<leader>s", group = "search" },
    { "<leader>u", group = "ui" },

    -- Outside <space>
    { "h", group = "comment" },

    -- Ctrl-w keys turned off in mappings.lua (Ctrl-arrows replace them): hidden from the popup,
    -- otherwise which-key still lists them with its built-in labels
    { "<C-w>h", hidden = true },
    { "<C-w>j", hidden = true },
    { "<C-w>k", hidden = true },
    { "<C-w>l", hidden = true },
    { "<C-w><C-h>", hidden = true },
    { "<C-w><C-j>", hidden = true },
    { "<C-w><C-k>", hidden = true },
    { "<C-w><C-l>", hidden = true },
    { "<C-w><BS>", hidden = true },
    { "<C-w><Left>", hidden = true },
    { "<C-w><Down>", hidden = true },
    { "<C-w><Up>", hidden = true },
    { "<C-w><Right>", hidden = true },
    { "<C-w>H", hidden = true },
    { "<C-w>J", hidden = true },
    { "<C-w>K", hidden = true },
    { "<C-w>L", hidden = true },
  },
}
