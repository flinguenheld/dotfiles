-- blink.cmp: completion menu (Insert mode and : command line), documentation beside it, signature popup
-- Snippets come from friendly-snippets, expanded by Neovim's vim.snippet; Tab / Shift-Tab jump between their fields
-- See all options: https://cmp.saghen.dev
-- ─────────────────────────────────────────────────────────────────────────────

return {
  -- ──────────────────────────────────────────────────────────────── Keys ────
  -- preset "enter": Ctrl-n / Ctrl-p (or ↑ / ↓ while the menu is open) move, Enter accepts,
  -- Ctrl-Space opens, Ctrl-e cancels, Tab / Shift-Tab jump between snippet fields, Ctrl-k toggles the signature
  keymap = {
    preset = "enter",
    ["<C-b>"] = false, -- documentation scroll moved to Ctrl-u / Ctrl-d (like man pages)
    ["<C-f>"] = false,
    -- Only while the documentation window is open; otherwise Insert mode's Ctrl-u / Ctrl-d
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  },

  -- ──────────────────────────────────────────────────────────── Completion ────
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 }, -- docs of the selected item, beside the menu
    ghost_text = { enabled = function() return vim.g.ghost_text ~= false end }, -- <space>ug toggles it
  },

  signature = { enabled = true }, -- function parameters, shown by itself after "("

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" }, -- + module names in require "…"
    },
    providers = {
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
    },
  },

  -- ─────────────────────────────────────────────────────────── Command line ────
  -- Tab / Shift-Tab or Ctrl-n / Ctrl-p move; the selected item is written into the line, Enter runs it
  cmdline = {
    keymap = {
      preset = "cmdline",
      ["<Left>"] = false, -- ← / → keep moving the cursor in the line
      ["<Right>"] = false,
    },
    completion = {
      menu = { auto_show = true }, -- shown while typing, not only after Tab
      list = { selection = { preselect = false } }, -- the first Ctrl-n picks the first item
    },
  },
}
