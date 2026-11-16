-- todo-comments.nvim: highlight TODO:, FIX:… in comments, ]t / [t to jump
-- Pickers per keyword group in mappings.lua (<space>t…), same groups as Helix
-- Keywords need a colon: "TODO: text" | See https://github.com/folke/todo-comments.nvim
-- ─────────────────────────────────────────────────────────────────────────────

local options = {
  merge_keywords = false, -- use only the keywords below, not the defaults
  keywords = {
    TODO = { icon = " ", color = "info", alt = { "QUESTION", "ASK" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO", "PERF", "PERFORMANCE", "OPTIMIZE" } },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "HACK", "TEST", "TEMP" } },
    FIX = {
      icon = " ",
      color = "error",
      alt = { "BUG", "FIXME", "FIXIT", "ISSUE", "XXX", "SAFETY", "FAILED", "DEBUG", "INVARIANT", "COMPLIANCE" },
    },
    HINT = { icon = "󰌵 ", color = "default", alt = { "MARK", "PASSED", "STUB", "MOCK" } },
  },
}

return options
