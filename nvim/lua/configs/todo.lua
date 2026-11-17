-- todo-comments.nvim: highlight TODO:, FIX:… in comments; pickers per keyword group (<space>t… in mappings.lua)
-- Same groups as Helix; a keyword needs a colon: "TODO: text"
-- See all options: https://github.com/folke/todo-comments.nvim
-- ─────────────────────────────────────────────────────────────────────────────

return {
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
