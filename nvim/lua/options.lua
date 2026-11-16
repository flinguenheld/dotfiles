-- Editor options (vim.o / vim.opt): numbers, indent, scrolloff…
-- Loads NvChad's defaults first, yours below override them
-- See :h options for the full list
-- ─────────────────────────────────────────────────────────────────────────────

require "nvchad.options"

local o = vim.o

-- ──────────────────────────────────────────────────────── From Helix ────

o.scrolloff = 10 -- keep 10 lines above/below the cursor
o.relativenumber = true -- relative numbers (current line shows its real number)
o.colorcolumn = "80" -- ruler at column 80
o.cursorlineopt = "both" -- highlight the whole cursor line, not only its number
o.winborder = "single" -- borders on popups (hover, signature, diagnostics…)

-- Show tabs as →··· and line ends as ↵
o.list = true
-- o.listchars = "tab:→·,eol:↵"
