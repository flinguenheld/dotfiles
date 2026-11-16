-- Keyboard shortcuts (vim.keymap.set / del)
-- Loads NvChad's shortcuts first, then adds or removes yours below
-- See them all with <space>? (cheatsheet) or <space>sk (keymaps picker)
-- ─────────────────────────────────────────────────────────────────────────────

require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local del = vim.keymap.del

-- map("n", ";", ":", { desc = "CMD enter command mode" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- ─────────────────────────────────────── Arrows instead of hjkl ────

-- Remove NvChad's Ctrl-hjkl (window switch in normal, cursor move in insert)
del({ "n", "i" }, "<C-h>")
del({ "n", "i" }, "<C-j>")
del({ "n", "i" }, "<C-k>")
del({ "n", "i" }, "<C-l>")

-- Disable plain hjkl in normal mode (use the arrows)
-- h is not here: it's comment (see the Comments section)
-- k is not here: it's LSP hover (see the LSP section)
map("n", "j", "<Nop>")
-- map("n", "k", "<Nop>")
map("n", "l", "<Nop>")

-- No arrows in insert mode (like Helix)
map("i", "<Up>", "<Nop>")
map("i", "<Down>", "<Nop>")
map("i", "<Left>", "<Nop>")
map("i", "<Right>", "<Nop>")

-- Ctrl-arrows: switch window
map("n", "<C-Left>", "<C-w>h", { desc = "window go left" })
map("n", "<C-Down>", "<C-w>j", { desc = "window go down" })
map("n", "<C-Up>", "<C-w>k", { desc = "window go up" })
map("n", "<C-Right>", "<C-w>l", { desc = "window go right" })

-- Ctrl-arrows from inside a terminal
map("t", "<C-Left>", "<C-\\><C-n><C-w>h", { desc = "window go left" })
map("t", "<C-Down>", "<C-\\><C-n><C-w>j", { desc = "window go down" })
map("t", "<C-Up>", "<C-\\><C-n><C-w>k", { desc = "window go up" })
map("t", "<C-Right>", "<C-\\><C-n><C-w>l", { desc = "window go right" })

-- Ctrl-w then Ctrl-arrow: move the window to that side
map("n", "<C-w><C-Left>", "<C-w>H", { desc = "window move left" })
map("n", "<C-w><C-Down>", "<C-w>J", { desc = "window move down" })
map("n", "<C-w><C-Up>", "<C-w>K", { desc = "window move up" })
map("n", "<C-w><C-Right>", "<C-w>L", { desc = "window move right" })

-- Alt-arrows: previous / next buffer
map("n", "<A-Left>", function() require("nvchad.tabufline").prev() end, { desc = "buffer goto prev" })
map("n", "<A-Right>", function() require("nvchad.tabufline").next() end, { desc = "buffer goto next" })

-- ──────────────────────────────────────────── Search (snacks pickers) ────

-- Remove NvChad's Telescope shortcuts (replaced by <space>s…)
del("n", "<leader>ff")
del("n", "<leader>fa")
del("n", "<leader>fw")
del("n", "<leader>fb")
del("n", "<leader>fo")
del("n", "<leader>fz")
del("n", "<leader>fh")
del("n", "<leader>ma")

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

-- ────────────────────────────────────────────────────────────────── LSP ────
-- NvChad's buffer LSP keys (gd, gD, <space>D, <space>ra, <space>w…) are
-- turned off in configs/lspconfig.lua

-- Remove Neovim's default LSP keys (replaced below)
del("n", "grn")
del({ "n", "x" }, "gra")
del("n", "grx")
del("n", "grr")
del("n", "gri")
del("n", "grt")
del("n", "gO")
del({ "i", "s" }, "<C-s>")

-- K: Vim's help for the word under cursor (:help in Vim script files, man elsewhere)
-- Mapped to itself so Neovim doesn't replace it with LSP hover
map("n", "K", "K", { desc = "help for word under cursor" })

-- Remove NvChad's LSP keys (replaced by <space>c…)
del("n", "<leader>ds")
del("n", "<leader>fm")

-- Go to (Helix-style, picker if several results)
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "goto definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "goto declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "goto references" })
map("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "goto implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "goto type definition" })

-- Hover docs (k is free since hjkl are off)
map("n", "k", function() vim.lsp.buf.hover() end, { desc = "LSP hover docs" })

-- Signature help (function parameters), also while typing them
map({ "n", "i" }, "<C-k>", function() vim.lsp.buf.signature_help() end, { desc = "LSP signature help" })

-- LSP tools
map("n", "<leader>cs", function() Snacks.picker.lsp_symbols() end, { desc = "symbols in file" })
map("n", "<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "symbols in project" })
map("n", "<leader>cc", function() Snacks.picker.lsp_incoming_calls() end, { desc = "incoming calls" })
map("n", "<leader>cC", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "outgoing calls" })
map("n", "<leader>cd", function() Snacks.picker.diagnostics_buffer() end, { desc = "diagnostics in file" })
map("n", "<leader>cD", function() Snacks.picker.diagnostics() end, { desc = "diagnostics in project" })
map("n", "<leader>cr", require "nvchad.lsp.renamer", { desc = "rename" })
map({ "n", "x" }, "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "code actions" })
map({ "n", "x" }, "<leader>cf", function() require("conform").format { lsp_format = "fallback" } end, { desc = "format" })
map("n", "<leader>ce", function() vim.diagnostic.open_float() end, { desc = "line diagnostic (popup)" })
map("n", "<leader>cl", function() vim.lsp.codelens.run() end, { desc = "run code lens" })

-- ────────────────────────────────────────────────────────────────── Git ────

-- Remove NvChad's Telescope git shortcuts (replaced by <space>g…)
del("n", "<leader>cm")
del("n", "<leader>gt")

-- Lazygit and pickers (snacks)
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "lazygit" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "status (changed files)" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "log of project" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "log of current file" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "log of current line" })
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "branches" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "diff (all changed hunks)" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "stash" })

-- Hunks: the block of changed lines under the cursor (gitsigns)
-- ga on a staged hunk unstages it
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "preview hunk" })
map("n", "<leader>ga", function() require("gitsigns").stage_hunk() end, { desc = "stage / unstage hunk" })
map("x", "<leader>ga", function() require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, { desc = "stage selected lines" })
map("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "reset hunk" })
map("x", "<leader>gr", function() require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, { desc = "reset selected lines" })
map("n", "<leader>gA", function() require("gitsigns").stage_buffer() end, { desc = "stage file" })
map("n", "<leader>gR", function() require("gitsigns").reset_buffer() end, { desc = "reset file" })

-- Info
map("n", "<leader>gB", function() require("gitsigns").blame_line { full = true } end, { desc = "blame line (popup)" })
map("n", "<leader>gD", function() require("gitsigns").diffthis() end, { desc = "diff file (side by side)" })
map({ "n", "x" }, "<leader>go", function() Snacks.gitbrowse() end, { desc = "open in browser" })

-- Navigation (Helix-style) and hunk text object (dig, yig, vig…)
map("n", "]g", function() require("gitsigns").nav_hunk "next" end, { desc = "next git hunk" })
map("n", "[g", function() require("gitsigns").nav_hunk "prev" end, { desc = "previous git hunk" })
map({ "o", "x" }, "ig", function() require("gitsigns").select_hunk() end, { desc = "git hunk" })

-- ───────────────────────────────────────────────────────────── Comments ────
-- h is the comment operator (Neovim's built-in gc, moved to a single key):
-- hh (line), h in visual, hip, hii, hig, h3↓…

-- Remove NvChad's <space>/ and Neovim's gc / gcc (replaced by h / hh)
del({ "n", "v" }, "<leader>/")
del({ "n", "x" }, "gc")
del("n", "gcc")

map({ "n", "x" }, "h", function() return require("vim._comment").operator() end, { expr = true, desc = "comment" })
map("n", "hh", function() return require("vim._comment").operator() .. "_" end, { expr = true, desc = "comment line" })

-- ─────────────────────────────────────────────────────────── Undo / redo ────
-- u is already undo in Vim; U was "undo all changes on the line"

map("n", "U", "<C-r>", { desc = "redo" })
map("n", "<C-r>", "<Nop>") -- redo is on U only (U still works: its mapping is non-recursive)

-- ──────────────────────────────────────────────────────── Todo comments ────
-- Same keyword groups as Helix, defined in configs/todo.lua (main + alt)

local todo = require("configs.todo").keywords

map("n", "<leader>ta", function() Snacks.picker.todo_comments() end, { desc = "all" })
map("n", "<leader>tt", function() Snacks.picker.todo_comments { keywords = { "TODO", unpack(todo.TODO.alt) } } end, { desc = "TODO" })
map("n", "<leader>ti", function() Snacks.picker.todo_comments { keywords = { "NOTE", unpack(todo.NOTE.alt) } } end, { desc = "NOTE / INFO" })
map("n", "<leader>tw", function() Snacks.picker.todo_comments { keywords = { "WARN", unpack(todo.WARN.alt) } } end, { desc = "WARN / HACK" })
map("n", "<leader>te", function() Snacks.picker.todo_comments { keywords = { "FIX", unpack(todo.FIX.alt) } } end, { desc = "FIX / BUG" })
map("n", "<leader>th", function() Snacks.picker.todo_comments { keywords = { "HINT", unpack(todo.HINT.alt) } } end, { desc = "HINT / MOCK" })

map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "previous todo comment" })

-- ─────────────────────────────────────────────────────────────────── UI ────

-- NvChad's theme picker moved from <space>th (now todo HINT)
map("n", "<leader>ut", function() require("nvchad.themes").open() end, { desc = "themes" })

-- Remove NvChad's number toggles (duplicates of <space>ul and <space>ur below)
del("n", "<leader>n")
del("n", "<leader>rn")
map("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "dismiss notifications" })

-- Toggles (snacks): which-key shows if each one is on or off
Snacks.toggle.option("list", { name = "whitespace (tabs, line ends)" }):map "<leader>uL"
Snacks.toggle.option("relativenumber", { name = "relative numbers" }):map "<leader>ur"
Snacks.toggle.option("spell", { name = "spell check" }):map "<leader>us"
Snacks.toggle.option("wrap", { name = "line wrap" }):map "<leader>uw"
Snacks.toggle.diagnostics():map "<leader>ud"
Snacks.toggle.dim():map "<leader>uD"
Snacks.toggle.inlay_hints():map "<leader>uh"
Snacks.toggle.line_number():map "<leader>ul"
Snacks.toggle.treesitter():map "<leader>uT"
Snacks.toggle({
  name = "git line blame",
  get = function() return require("gitsigns.config").config.current_line_blame end,
  set = function(state) require("gitsigns").toggle_current_line_blame(state) end,
}):map "<leader>ub"

-- ──────────────────────────────────────────────────── Words (snacks) ────
-- Other uses of the word under the cursor (from the LSP) are highlighted

map("n", "]r", function() Snacks.words.jump(vim.v.count1) end, { desc = "next reference" })
map("n", "[r", function() Snacks.words.jump(-vim.v.count1) end, { desc = "previous reference" })

-- ───────────────────────────────────────────────────────── Jump (flash) ────
-- f / F / t / T are enhanced automatically (see configs/flash.lua)

map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "flash jump" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "flash treesitter select" })
map("o", "r", function() require("flash").remote() end, { desc = "flash remote" })
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "flash treesitter search" })

-- ────────────────────────────────────────────────────────────── Buffers ────

-- Remove NvChad's buffer keys (replaced by <space>b…)
del("n", "<leader>b")
del("n", "<leader>x")

map("n", "<leader>bq", function() require("nvchad.tabufline").close_buffer() end, { desc = "close current (keeps windows)" })
map("n", "<leader>ba", function() require("nvchad.tabufline").closeAllBufs(false) end, { desc = "close all others" })
map("n", "<leader>bs", function() Snacks.picker.buffers() end, { desc = "search buffers" })

-- ───────────────────────────────────────────────────── Explorer (snacks) ────

-- Remove NvChad's nvim-tree keys (replaced by <space>e)
del("n", "<C-n>")
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "file explorer" })

-- ───────────────────────────────────────────────────────────────── Help ────

-- NvChad's cheatsheet moved from <space>ch (inside the code group)
del("n", "<leader>ch")
map("n", "<leader>?", "<cmd>NvCheatsheet<CR>", { desc = "cheatsheet" })

-- ───────────────────────────────────────────────────────────── Terminal ────

-- No snacks equivalent for NvChad's hidden terminals picker
del("n", "<leader>pt")
