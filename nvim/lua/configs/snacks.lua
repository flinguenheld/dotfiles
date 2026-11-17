-- snacks.nvim: one plugin, many modules; the ones with a setup are switched on here
-- The others (bufdelete, dim, gitbrowse, lazygit, rename, toggle) are functions called from lua/mappings.lua
-- See all modules and options: https://github.com/folke/snacks.nvim
-- ─────────────────────────────────────────────────────────────────────────────

return {
  bigfile = { enabled = true }, -- turn off heavy features on very large files
  dashboard = { enabled = true }, -- start screen (recent files, keys…)
  explorer = { enabled = true }, -- file tree (<space>e); also opens on `nvim folder/`
  image = { enabled = true }, -- show images (Markdown, picker preview) in WezTerm
  indent = { enabled = true }, -- indent guides
  input = { enabled = true }, -- popup when Neovim asks for text (rename…)
  notifier = { enabled = true }, -- notifications as popups + history (<space>sn)
  -- quickfile = { enabled = true }, -- show the file faster on `nvim file`
  scope = { enabled = true }, -- ii / ai text objects, [i / ]i jumps
  statuscolumn = { enabled = true }, -- signs left (diagnostics, marks), git right
  words = { enabled = true }, -- highlight LSP references, ]r / [r to jump

  -- ───────────────────────────────────────────────
  -- ────────────────────────────────────── PICKER ─────
  -- hjkl are off in this config: the arrows move in the lists, Ctrl-d / Ctrl-u scroll
  picker = {
    enabled = true,
    win = {
      -- the text box at the top (Insert mode, Normal mode after Esc)
      -- (key names written like snacks' defaults, "<c-j>", so they replace them)
      input = {
        keys = {
          ["<c-j>"] = false,
          ["<c-k>"] = false,
          ["j"] = false,
          ["k"] = false,
        },
      },
      -- the list of results (Normal mode)
      list = {
        keys = {
          ["<c-j>"] = false,
          ["<c-k>"] = false,
          ["j"] = false,
          ["k"] = false,
        },
      },
    },
    sources = {
      -- the explorer: Enter opens a file or opens / closes a folder (h / l off)
      explorer = {
        win = {
          list = {
            keys = {
              ["h"] = false,
              ["l"] = false,
            },
          },
        },
      },
    },
  },
}
