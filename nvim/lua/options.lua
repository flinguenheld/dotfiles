-- Editor options (vim.o / vim.g): numbers, indent, search, splits…
-- Loaded from init.lua before the plugins; one option per line, in alphabetical order
-- See :h options for the full list
-- ─────────────────────────────────────────────────────────────────────────────

local o = vim.o

-- Clipboard used by yank/paste (choose one):
o.clipboard = "" -- Neovim's default, like Helix: only Neovim's registers; <space>y copies to the system
-- o.clipboard = "unnamed" -- the "* register: the primary selection (middle click on Linux)
-- o.clipboard = "unnamed,unnamedplus" -- both: yank goes to the two, paste reads the system clipboard
-- o.clipboard = "unnamedplus" -- the "+ register: every yank/delete goes to the system clipboard

o.colorcolumn = "80" -- ruler at column 80
o.cursorline = true -- highlight the cursor line…
o.cursorlineopt = "both" -- …the whole line and its number
o.expandtab = true -- indent with spaces, not tabs
-- o.guicursor = "n-c-sm:block,i-ci-ve:ver25,r-cr-o-v:hor20,t:block-blinkon500-blinkoff500-TermCursor" -- Visual = underline
o.ignorecase = true -- search ignores case…
o.inccommand = "split" -- :s/…/… previews every change in a split window
o.laststatus = 3 -- one statusline for all windows
o.list = true -- show the characters from listchars
o.listchars = "eol:↵,tab:→·" -- tabs as →···, line ends as ↵
o.mouse = "a" -- mouse in all modes (Neovim's default "nvi" leaves out the command line)
o.number = true -- line numbers…
o.relativenumber = true -- …relative to the cursor line (which shows its real number)
o.scrolloff = 10 -- keep 10 lines above/below the cursor
o.shiftwidth = 2 -- indent width (language files like Rust or Python set their own)
o.showmode = false -- no "-- INSERT --": lualine shows the mode
o.signcolumn = "yes" -- always show the sign column, so text doesn't shift
o.smartcase = true -- …unless the search has a capital letter
o.softtabstop = 2 -- Tab / Backspace in Insert mode move by 2 columns
o.splitbelow = true -- horizontal splits open below
o.splitkeep = "screen" -- text doesn't move when a split opens
o.splitright = true -- vertical splits open on the right
o.tabstop = 2 -- a tab character is shown 2 columns wide
o.timeoutlen = 400 -- wait time (ms) for multi-key shortcuts
o.undofile = true -- undo history survives restarts (~/.local/state/nvim/undo)
o.updatetime = 250 -- CursorHold after 250 ms (gitsigns blame, LSP highlights)
o.winborder = "single" -- borders on popups (hover, signature, diagnostics…)
o.wrap = false -- don't wrap long lines

-- Remote-plugin providers: off (rplugin is disabled in configs/lazy.lua)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
