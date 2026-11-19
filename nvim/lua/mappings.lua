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
map({ "n", "x", "o" }, "h", "<Nop>") -- h alone: nothing; h… keys are surround (see Surround)
map("o", "k", "<Nop>") -- k is comment in Normal and Visual (see Comments)

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

-- ─────────────────────────────────────────────── Yank history (yanky) ────
-- p / P / gp / gP paste as usual, through yanky so it knows what was pasted
-- Right after a paste, Ctrl-p / Ctrl-n swap it for an older / newer yank (they were ↑ / ↓ in Normal mode)
-- History picker: <space>sy (Search section)

map({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "paste after" })
map({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "paste before" })
map("n", "<C-p>", "<Plug>(YankyNextEntry)", { desc = "after paste: newer yank" })
map("n", "<C-n>", "<Plug>(YankyPreviousEntry)", { desc = "after paste: older yank" })

-- ───────────────────────────────────────────────────────────── Comments ────
-- k is the comment operator (Neovim's built-in gc, moved to a single key):
-- kk (line), k in Visual, kip, k3↓…

del({ "n", "x" }, "gc")
del("n", "gcc")
del("o", "gc") -- comment text object (dgc): replaced by mini.ai's ic / ac

map({ "n", "x" }, "k", function() return require("vim._comment").operator() end, { expr = true, desc = "comment" })
map("n", "kk", function() return require("vim._comment").operator() .. "_" end, { expr = true, desc = "comment line" })

-- ────────────────────────────────────────────────────────────────── LSP ────

-- Hover docs on <space>k, like Helix
map("n", "<leader>k", function() vim.lsp.buf.hover() end, { desc = "LSP hover docs" })

-- K: Vim's help for the word under cursor (:help in Vim script files, man elsewhere)
-- Mapped to itself so Neovim doesn't replace it with LSP hover (it only does when K isn't mapped)
map("n", "K", "K", { desc = "help / man page for word under cursor" })

-- Neovim's LSP keys: removed (replaced below by Helix-style g… keys and <space>c…)
-- ]d / [d / ]D / [D (next / previous / last / first diagnostic) are kept: same as Helix
del("n", "grn")
del({ "n", "x" }, "gra")
del("n", "grr")
del("n", "gri")
del("n", "grt")
del("n", "grx")
del("n", "gO")
del("n", "<C-w>d")
del("n", "<C-w><C-d>")

-- Go to (Helix-style, picker if several results)
-- gi was Neovim's "insert where Insert mode was left" (still there as `^i)
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "goto definition" })
map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "goto declaration" })
map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "goto references" })
map("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "goto implementation" })
map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "goto type definition" })

-- Code tools (<space>c)
map("n", "<leader>cs", function() Snacks.picker.lsp_symbols() end, { desc = "symbols in file" })
map("n", "<leader>cS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "symbols in project" })
map("n", "<leader>cc", function() Snacks.picker.lsp_incoming_calls() end, { desc = "incoming calls" })
map("n", "<leader>cC", function() Snacks.picker.lsp_outgoing_calls() end, { desc = "outgoing calls" })
map("n", "<leader>cd", function() Snacks.picker.diagnostics_buffer() end, { desc = "diagnostics in file" })
map({ "n", "x" }, "<leader>cf", function() require("conform").format { lsp_format = "fallback" } end, { desc = "format (file / selection)" })
map("n", "<leader>cD", function() Snacks.picker.diagnostics() end, { desc = "diagnostics in project" })
map("n", "<leader>ce", function() vim.diagnostic.open_float() end, { desc = "line diagnostic (popup)" })
map("n", "<leader>cr", function() vim.lsp.buf.rename() end, { desc = "rename (snacks input)" })
map({ "n", "x" }, "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "code actions" })
map("n", "<leader>cl", function() vim.lsp.codelens.run() end, { desc = "run code lens" })

-- Signature help: blink's popup (opens by itself, Ctrl-k toggles it, see configs/blink.lua)
del({ "i", "s" }, "<C-s>")

-- Digraphs off (Ctrl-k + two letters → é, €…): in Insert mode blink's Ctrl-k falls back here
map("i", "<C-k>", "<Nop>")
map("c", "<C-k>", "<Nop>")

-- ─────────────────────────────────────────────────────────────────── Git ────
-- gitsigns: hunks (blocks of changed lines) of the current file; snacks: lazygit, pickers, browser

-- Lazygit and pickers (snacks)
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "lazygit" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "status (changed files)" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "log of project" })
map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "log of current file" })
map("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "log of current line" })
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "branches" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "diff (all changed hunks)" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "stash" })

-- Hunks (gitsigns); ga on a staged hunk unstages it
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

-- ]c / [c: next / previous change; in diff mode Neovim's own jump, otherwise git hunks
map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    require("gitsigns").nav_hunk "next"
  end
end, { desc = "next change (git hunk / diff)" })
map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    require("gitsigns").nav_hunk "prev"
  end
end, { desc = "previous change (git hunk / diff)" })

-- Hunk text object: dig, yig, vig…
map({ "o", "x" }, "ig", function() require("gitsigns").select_hunk() end, { desc = "git hunk" })

-- ────────────────────────────────────────────────────────────── Surround ────
-- h is the surround prefix: hh add, hd delete, hr replace, instead of nvim-surround's ys / ds / cs
-- (Helix has them on ms / md / mr; m stays Neovim's marks here); . repeats them

map("n", "hh", "<Plug>(nvim-surround-normal)", { desc = 'surround add (motion, char): hhiw"' })
map("n", "hH", "<Plug>(nvim-surround-normal-cur)", { desc = "surround add around the line" })
map("n", "hS", "<Plug>(nvim-surround-normal-line)", { desc = "surround add, pair on own lines" })
map("n", "hd", "<Plug>(nvim-surround-delete)", { desc = 'surround delete (char): hd"' })
map("n", "hr", "<Plug>(nvim-surround-change)", { desc = "surround replace (old, new): hr\"'" })

-- Visual: wrap the selection
map("x", "hh", "<Plug>(nvim-surround-visual)", { desc = "surround selection" })
map("x", "hS", "<Plug>(nvim-surround-visual-line)", { desc = "surround selection, on new lines" })

-- ────────────────────────────────────────────────────────── Jump (flash) ────
-- f / F / t / T are enhanced by flash itself (configs/flash.lua)
-- s / S replace Neovim's s (= cl) and S (= cc); R in Visual was the same as S

map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "flash jump" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "flash treesitter select" })
map("o", "r", function() require("flash").remote() end, { desc = "flash remote (yr…: act there, stay here)" })
map({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "flash treesitter search" })

-- While typing a / or ? search: labels on the matches, for this search only
map("c", "<C-s>", function() require("flash").toggle() end, { desc = "flash labels in search" })

-- ────────────────────────────────────────────────────── Treesitter jumps ────
-- Like Helix: ]f function, ]a argument, ]t class/type, ]k comment (k is the comment key here)
-- They replace Neovim's ]a / [a (argument list) and ]t / [t (tag stack)
-- Also in Visual (extends the selection) and Operator-pending mode (d]f deletes up to the next function)

local function ts_next(query)
  return function() require("nvim-treesitter-textobjects.move").goto_next_start(query, "textobjects") end
end
local function ts_prev(query)
  return function() require("nvim-treesitter-textobjects.move").goto_previous_start(query, "textobjects") end
end

map({ "n", "x", "o" }, "]f", ts_next "@function.outer", { desc = "next function" })
map({ "n", "x", "o" }, "[f", ts_prev "@function.outer", { desc = "previous function" })
map({ "n", "x", "o" }, "]a", ts_next "@parameter.inner", { desc = "next argument" })
map({ "n", "x", "o" }, "[a", ts_prev "@parameter.inner", { desc = "previous argument" })
map({ "n", "x", "o" }, "]t", ts_next "@class.outer", { desc = "next class / type" })
map({ "n", "x", "o" }, "[t", ts_prev "@class.outer", { desc = "previous class / type" })
map({ "n", "x", "o" }, "]k", ts_next "@comment.outer", { desc = "next comment" })
map({ "n", "x", "o" }, "[k", ts_prev "@comment.outer", { desc = "previous comment" })

-- ───────────────────────────────────────────────────────── Todo comments ────
-- Same keyword groups as Helix, defined in configs/todo.lua (main + alt); no ]t / [t (class / type jumps)

local todo = require("configs.todo").keywords

map("n", "<leader>ta", function() Snacks.picker.todo_comments() end, { desc = "all" })
map("n", "<leader>tt", function() Snacks.picker.todo_comments { keywords = { "TODO", unpack(todo.TODO.alt) } } end, { desc = "TODO" })
map("n", "<leader>ti", function() Snacks.picker.todo_comments { keywords = { "NOTE", unpack(todo.NOTE.alt) } } end, { desc = "NOTE / INFO" })
map("n", "<leader>tw", function() Snacks.picker.todo_comments { keywords = { "WARN", unpack(todo.WARN.alt) } } end, { desc = "WARN / HACK" })
map("n", "<leader>te", function() Snacks.picker.todo_comments { keywords = { "FIX", unpack(todo.FIX.alt) } } end, { desc = "FIX / BUG" })
map("n", "<leader>th", function() Snacks.picker.todo_comments { keywords = { "HINT", unpack(todo.HINT.alt) } } end, { desc = "HINT / MOCK" })

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
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "marks" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "jump list" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "undo history" })
map("n", "<leader>sR", function() Snacks.picker.registers() end, { desc = "registers (paste on Enter)" })
map("n", "<leader>sy", function() Snacks.picker.yanky() end, { desc = "yank history (paste on Enter)" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "quickfix list" })
map("n", "<leader>ss", function() Snacks.picker.resume() end, { desc = "resume last picker" })
map("n", "<leader>sp", function() Snacks.picker.pickers() end, { desc = "all pickers" })

-- Search and replace in the project (grug-far); in Visual mode the selection fills the search field
-- Code symbols: <space>cr (LSP rename) knows scopes; grug-far replaces text (comments, docs, config…)
map({ "n", "x" }, "<leader>r", function() require("grug-far").open() end, { desc = "search & replace (project)" })

-- ────────────────────────────────────────────────────────────── Buffers ────

map("n", "<leader>bq", function() Snacks.bufdelete() end, { desc = "close current" })
map("n", "<leader>ba", function() Snacks.bufdelete.other() end, { desc = "close all others" })
map("n", "<leader>bs", function() Snacks.picker.buffers() end, { desc = "search buffers" })
map("n", "<leader>bb", "<Cmd>BufferLinePick<CR>", { desc = "pick buffer by letter" })

-- Previous / next buffer in the bar's order (bufferline)
-- Replaces Neovim's [b / ]b (removed); [B / ]B (first / last buffer) are kept
-- Tab stays free: in the terminal it's the same key as Ctrl-i (jump forward, the opposite of Ctrl-o)
map("n", "<M-Left>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "previous buffer" })
map("n", "<M-Right>", "<Cmd>BufferLineCycleNext<CR>", { desc = "next buffer" })
del("n", "[b")
del("n", "]b")

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

-- Esc clears the search highlight (after / ? * #); Neovim's Ctrl-L does the same and is kept on purpose
map("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "clear search highlight" })

map("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "dismiss notifications" })
map("n", "<leader>ut", function() Snacks.picker.colorschemes() end, { desc = "colour schemes (this session only)" })

-- Statusline toggle (<space>up): lualine's current config (from configs/lualine.lua), and one of its parts by name
local function lualine_part(config, section, name)
  for _, part in ipairs(config.sections[section]) do
    if type(part) == "table" and part[1] == name then return part end
  end
end

-- Toggles (snacks): which-key shows if each one is on or off
Snacks.toggle({
  name = "git line blame",
  get = function() return require("gitsigns.config").config.current_line_blame end,
  set = function(state) require("gitsigns").toggle_current_line_blame(state) end,
}):map "<leader>ub"
Snacks.toggle({
  name = "colour squares (#ff8800, rgb()…)",
  get = function() return require("nvim-highlight-colors").is_active() end,
  set = function(state)
    if state then
      require("nvim-highlight-colors").turnOn()
    else
      require("nvim-highlight-colors").turnOff()
    end
  end,
}):map "<leader>uc"
Snacks.toggle.diagnostics():map "<leader>ud"
Snacks.toggle.dim():map "<leader>uD"
Snacks.toggle({
  name = "format on save",
  get = function() return vim.g.autoformat ~= false end, -- read by configs/conform.lua
  set = function(state) vim.g.autoformat = state end,
}):map "<leader>uf"
Snacks.toggle({
  name = "ghost text (completion)",
  get = function() return vim.g.ghost_text ~= false end, -- read by configs/blink.lua
  set = function(state) vim.g.ghost_text = state end,
}):map "<leader>ug"
Snacks.toggle.inlay_hints():map "<leader>uh"
Snacks.toggle.line_number():map "<leader>ul"
Snacks.toggle.option("list", { name = "whitespace (tabs, line ends)" }):map "<leader>uL"
Snacks.toggle({
  name = "statusline: path from root",
  get = function() return lualine_part(require("lualine").get_config(), "lualine_c", "filename").path == 1 end,
  set = function(state)
    local config = require("lualine").get_config()
    lualine_part(config, "lualine_c", "filename").path = state and 1 or 0
    require("lualine").setup(config)
  end,
}):map "<leader>up"
Snacks.toggle.option("relativenumber", { name = "relative numbers" }):map "<leader>ur"
Snacks.toggle.option("spell", { name = "spell check" }):map "<leader>us"
Snacks.toggle.option("wrap", { name = "line wrap" }):map "<leader>uw"

-- ──────────────────────────────────────────────────────── Words (snacks) ────
-- Other uses of the word under the cursor (from the LSP) are highlighted

map("n", "]r", function() Snacks.words.jump(vim.v.count1) end, { desc = "next reference" })
map("n", "[r", function() Snacks.words.jump(-vim.v.count1) end, { desc = "previous reference" })

-- ───────────────────────────────────────────────────────────────── Help ────
-- <space>? = everything to look things up: keys, commands, help, plugins, health

map("n", "<leader>??", function() require("which-key").show { global = false } end, { desc = "keys of this buffer (which-key)" })
map("n", "<leader>?k", function() Snacks.picker.keymaps() end, { desc = "all keymaps" })
map("n", "<leader>?c", function() Snacks.picker.commands() end, { desc = "commands" })
map("n", "<leader>?h", function() Snacks.picker.help() end, { desc = "help pages" })
map("n", "<leader>?a", function() Snacks.picker.autocmds() end, { desc = "autocmds" })
map("n", "<leader>?n", function() Snacks.picker.notifications() end, { desc = "notifications history" })
map("n", "<leader>?l", "<Cmd>Lazy<CR>", { desc = "Lazy (plugins)" })
map("n", "<leader>?m", "<Cmd>Mason<CR>", { desc = "Mason (servers, formatters)" })
map("n", "<leader>?C", "<Cmd>checkhealth<CR>", { desc = "checkhealth" })
