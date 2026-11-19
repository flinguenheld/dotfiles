-- yanky.nvim: yank history (p / P / gp / gP, Ctrl-p / Ctrl-n, <space>sy in mappings.lua)
-- After a paste, Ctrl-p / Ctrl-n swap the pasted text for an older / newer yank
-- See all options: https://github.com/gbprod/yanky.nvim
-- ─────────────────────────────────────────────────────────────────────────────

return {
  ring = {
    history_length = 100, -- yanky's default: the last 100 yanks
    storage = "shada", -- saved across sessions in Neovim's shada file (needs ! in the shada option, it's there)
  },
  system_clipboard = {
    sync_with_ring = true, -- text copied in another app is added to the history when Neovim gets focus back
  },
  highlight = {
    on_put = true, -- flash the pasted text
    on_yank = true, -- flash the yanked text (replaces the TextYankPost autocmd)
    timer = 300, -- default 500
  },
}
