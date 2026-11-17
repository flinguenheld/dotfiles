-- Keyboard shortcuts (vim.keymap.set / del), one section per topic
-- One shortcut per action: a Neovim key replaced here is removed (del) or turned off (<Nop>)
-- Loaded from init.lua after the autocmds
-- ─────────────────────────────────────────────────────────────────────────────

local map = vim.keymap.set
local del = vim.keymap.del

-- ─────────────────────────────────────── Arrows instead of hjkl ────

-- hjkl off in Normal, Visual and Operator-pending mode (the arrows do every move)
map({ "n", "x", "o" }, "j", "<Nop>")
map({ "n", "x", "o" }, "l", "<Nop>")
-- map({ "n", "x", "o" }, "h", "<Nop>") -- remapped: comment (see Comments)
-- map({ "n", "x", "o" }, "k", "<Nop>") -- remapped: LSP hover (see LSP)
map("o", "h", "<Nop>")
map({ "x", "o" }, "k", "<Nop>")

-- No arrows, Home/End or PageUp/PageDown in Insert mode (like Helix)
map("i", "<Up>", "<Nop>")
map("i", "<Down>", "<Nop>")
map("i", "<Left>", "<Nop>")
map("i", "<Right>", "<Nop>")
map("i", "<Home>", "<Nop>")
map("i", "<End>", "<Nop>")
map("i", "<PageUp>", "<Nop>")
map("i", "<PageDown>", "<Nop>")

-- ──────────────────────────────────────────────────────────── Windows ────
-- Other window commands stay on Ctrl-w (splits s/v, close q, only o, equal =…)

-- Ctrl-arrows: go to the window on that side
map("n", "<C-Left>", "<C-w>h", { desc = "window go left" })
map("n", "<C-Down>", "<C-w>j", { desc = "window go down" })
map("n", "<C-Up>", "<C-w>k", { desc = "window go up" })
map("n", "<C-Right>", "<C-w>l", { desc = "window go right" })

-- Ctrl-w then Ctrl-arrow: move the window to that side
map("n", "<C-w><C-Left>", "<C-w>H", { desc = "window move left" })
map("n", "<C-w><C-Down>", "<C-w>J", { desc = "window move down" })
map("n", "<C-w><C-Up>", "<C-w>K", { desc = "window move up" })
map("n", "<C-w><C-Right>", "<C-w>L", { desc = "window move right" })

-- Neovim's own keys for the same actions: off (the mappings above still work, they're non-recursive)
map("n", "<C-w>h", "<Nop>")
map("n", "<C-w>j", "<Nop>")
map("n", "<C-w>k", "<Nop>")
map("n", "<C-w>l", "<Nop>")
map("n", "<C-w><C-h>", "<Nop>")
map("n", "<C-w><C-j>", "<Nop>")
map("n", "<C-w><C-k>", "<Nop>")
map("n", "<C-w><C-l>", "<Nop>")
map("n", "<C-w><BS>", "<Nop>")
map("n", "<C-w><Left>", "<Nop>")
map("n", "<C-w><Down>", "<Nop>")
map("n", "<C-w><Up>", "<Nop>")
map("n", "<C-w><Right>", "<Nop>")
map("n", "<C-w>H", "<Nop>")
map("n", "<C-w>J", "<Nop>")
map("n", "<C-w>K", "<Nop>")
map("n", "<C-w>L", "<Nop>")

-- ───────────────────────────────────────────────────────── Clipboard ────
-- y / d / p stay in Neovim's registers (clipboard = "" in options.lua, like Helix)
-- Paste from the system with WezTerm Ctrl-Shift-V (or "+p)

map({ "n", "x" }, "<leader>y", '"+y', { desc = "yank to system clipboard" })

-- ───────────────────────────────────────────────────────────── Comments ────
-- h is the comment operator (Neovim's built-in gc, moved to a single key):
-- hh (line), h in Visual, hip, h3↓…

del({ "n", "x" }, "gc")
del("n", "gcc")
-- gc in Operator-pending mode (comment text object, dgc) is kept until mini.ai (step 16)

map({ "n", "x" }, "h", function() return require("vim._comment").operator() end, { expr = true, desc = "comment" })
map("n", "hh", function() return require("vim._comment").operator() .. "_" end, { expr = true, desc = "comment line" })

-- ────────────────────────────────────────────────────────────────── LSP ────

-- K: Vim's help for the word under cursor (:help in Vim script files, man elsewhere)
-- Mapped to itself so Neovim doesn't replace it with LSP hover
map("n", "K", "K", { desc = "help for word under cursor" })

-- Hover docs (k is free since hjkl are off)
map("n", "k", function() vim.lsp.buf.hover() end, { desc = "LSP hover docs" })

-- ─────────────────────────────────────────────────────────── Undo / redo ────
-- u is already undo; U was "undo all changes on the line"

map("n", "U", "<C-r>", { desc = "redo" })
map("n", "<C-r>", "<Nop>") -- redo is on U only (U still works: its mapping is non-recursive)

-- ──────────────────────────────────────────── Search (snacks pickers) ────

map("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "files" })
map("n", "<leader>sF", function() Snacks.picker.files { hidden = true } end, { desc = "files + hidden" })
map("n", "<leader>sa", function() Snacks.picker.files { hidden = true, ignored = true, follow = true } end, { desc = "all files (hidden + ignored)" })
map("n", "<leader>sr", function() Snacks.picker.recent() end, { desc = "recent files" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "grep (text in project)" })
map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "grep word / selection" })
map("n", "<leader>sl", function() Snacks.picker.lines() end, { desc = "lines in file" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "help pages" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "keymaps" })
map("n", "<leader>sc", function() Snacks.picker.commands() end, { desc = "commands" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "marks" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "jump list" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "undo history" })
map("n", "<leader>sR", function() Snacks.picker.registers() end, { desc = "registers (paste on Enter)" })
map("n", "<leader>sn", function() Snacks.picker.notifications() end, { desc = "notifications history" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "quickfix list" })
map("n", "<leader>ss", function() Snacks.picker.resume() end, { desc = "resume last picker" })
map("n", "<leader>sp", function() Snacks.picker.pickers() end, { desc = "all pickers" })

-- ────────────────────────────────────────────────────────────── Buffers ────

map("n", "<leader>bq", function() Snacks.bufdelete() end, { desc = "close current (keeps windows)" })
map("n", "<leader>ba", function() Snacks.bufdelete.other() end, { desc = "close all others" })
map("n", "<leader>bs", function() Snacks.picker.buffers() end, { desc = "search buffers" })

-- ───────────────────────────────────────────────────── Explorer (snacks) ────

-- Put the cursor in the explorer, opening it first if it's closed
local function explorer_focus()
  local explorer = Snacks.picker.get({ source = "explorer" })[1]
  if explorer then
    explorer:focus()
  else
    Snacks.explorer()
  end
end

map("n", "<leader>e", function() Snacks.explorer() end, { desc = "file explorer (open / close)" })
map("n", "<leader>E", explorer_focus, { desc = "file explorer (go to)" })

-- ─────────────────────────────────────────────────────────────────── UI ────

map("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "dismiss notifications" })
map("n", "<leader>ut", function() Snacks.picker.colorschemes() end, { desc = "colour schemes (this session only)" })

-- Toggles (snacks): which-key shows if each one is on or off
Snacks.toggle.diagnostics():map "<leader>ud"
Snacks.toggle.dim():map "<leader>uD"
Snacks.toggle.inlay_hints():map "<leader>uh"
Snacks.toggle.line_number():map "<leader>ul"
Snacks.toggle.option("list", { name = "whitespace (tabs, line ends)" }):map "<leader>uL"
Snacks.toggle.option("relativenumber", { name = "relative numbers" }):map "<leader>ur"
Snacks.toggle.option("spell", { name = "spell check" }):map "<leader>us"
Snacks.toggle.option("wrap", { name = "line wrap" }):map "<leader>uw"

-- ──────────────────────────────────────────────────────── Words (snacks) ────
-- Other uses of the word under the cursor (from the LSP) are highlighted

map("n", "]r", function() Snacks.words.jump(vim.v.count1) end, { desc = "next reference" })
map("n", "[r", function() Snacks.words.jump(-vim.v.count1) end, { desc = "previous reference" })

-- ───────────────────────────────────────────────────────────────── Help ────
-- All shortcuts: <space>sk (keymaps picker); this one: only the current buffer's

map("n", "<leader>?", function() require("which-key").show { global = false } end, { desc = "keys of this buffer (which-key)" })
