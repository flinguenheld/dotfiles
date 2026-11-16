-- which-key: the popup listing the next keys after <space>, g, Ctrl-w…
-- Here: group names shown in that popup (the shortcuts are in mappings.lua)
-- See all options: https://github.com/folke/which-key.nvim
-- ─────────────────────────────────────────────────────────────────────────────

local options = {
  spec = {
    { "<leader>b", group = "buffers" },
    { "<leader>c", group = "code (lsp)" },
    { "<leader>g", group = "git" },
    { "<leader>s", group = "search" },
    { "<leader>t", group = "todo comments" },
    { "<leader>u", group = "ui" },

    -- Outside <space>
    { "h", group = "comment" },
  },
}

return options
