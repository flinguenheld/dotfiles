-- mini.ai: a / i text objects (dif, cia, yaq…), letters like Helix; searches forward if the cursor isn't inside
-- Treesitter ones use the queries of nvim-treesitter-textobjects; which-key labels are in configs/whichkey.lua
-- See all options: :h mini.ai
-- ─────────────────────────────────────────────────────────────────────────────

local ai = require "mini.ai"
local ts = ai.gen_spec.treesitter

return {
  -- In alphabetical order; mini.ai also keeps its own a (argument), b (any bracket), q (any quote)
  custom_textobjects = {
    c = ts { a = "@comment.outer", i = "@comment.outer" }, -- comment (few languages have an inner query)
    f = ts { a = "@function.outer", i = "@function.inner" }, -- function definition (mini.ai's f moved to u)
    t = ts { a = "@class.outer", i = "@class.inner" }, -- type / class (mini.ai's t moved to x)
    u = ai.gen_spec.function_call(), -- function call: foo(…)
    x = { "<(%w-)%f[^<%w][^<>]->.-</%1%s->", "^<.->().*()</.->$" }, -- HTML / XML tag (mini.ai's own t pattern)
  },

  -- No "next" / "last" variants (an, in, al, il): an / in are Neovim's grow / shrink selection by syntax node
  mappings = {
    around_next = "",
    inside_next = "",
    around_last = "",
    inside_last = "",
  },
}
