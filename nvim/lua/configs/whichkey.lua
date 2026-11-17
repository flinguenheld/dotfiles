-- which-key: the popup listing the next keys after <space>, g, Ctrl-w, [, ]…
-- Here: popup style and group names (the shortcuts themselves are in mappings.lua)
-- See all options: https://github.com/folke/which-key.nvim
-- ─────────────────────────────────────────────────────────────────────────────

return {
  -- preset = "classic",
  -- preset = "modern",
  preset = "helix",

  -- When the popup opens: <auto> = every prefix, except single letters other than g / z / Z
  -- m added by hand for the surround keys (m + another letter still sets a mark)
  triggers = {
    { "<auto>", mode = "nxso" },
    { "m", mode = { "n", "x" } },
  },

  spec = {
    { "<leader>b", group = "buffers" },
    { "<leader>c", group = "code" },
    { "<leader>g", group = "git" },
    { "<leader>s", group = "search" },
    { "<leader>t", group = "todo" },
    { "<leader>u", group = "ui" },

    -- Outside <space>
    { "h", group = "comment" },
    { "m", group = "surround (other letters: set mark)", mode = { "n", "x" } },

    -- Text objects from mini.ai (configs/miniai.lua): which-key's built-in labels for ab / at are Neovim's
    { mode = { "o", "x" },
      { "aa", desc = "argument (+ comma)" },
      { "ab", desc = "any bracket ( [ {" },
      { "ac", desc = "comment" },
      { "af", desc = "function" },
      { "aq", desc = "any quote \" ' `" },
      { "at", desc = "type / class" },
      { "au", desc = "function call" },
      { "ax", desc = "tag (HTML / XML)" },
      { "ia", desc = "inner argument" },
      { "ib", desc = "inner any bracket" },
      { "ic", desc = "comment" },
      { "if", desc = "inner function" },
      { "iq", desc = "inner any quote" },
      { "it", desc = "inner type / class" },
      { "iu", desc = "inner function call (arguments)" },
      { "ix", desc = "inner tag" },
    },

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
