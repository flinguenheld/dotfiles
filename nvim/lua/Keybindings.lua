local keymap = vim.api.nvim_set_keymap
local opt = {noremap = true }
local opts = { noremap=true, silent=true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


-- keymap('', 'B', '^', {})	-- Applique aux modes Normal, Visual, Select, Operator-pending
-- keymap('', 'W', '$', {})

keymap('n', 'l', '.', opt)  -- Derniere commande
keymap("n", "<leader><esc>", "<cmd>nohlsearch<cr>", opt)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opt)
keymap("v", ">", ">gv", opt)

-- Move text up and down
keymap("v", "<M-down>", ":m .+1<CR>==", opt)
keymap("v", "<M-up>",   ":m .-2<CR>==", opt)

keymap("n", "<M-up>",     "<Esc>:m .-2<CR>", opt)
keymap("n", "<M-down>",   "<Esc>:m .+1<CR>", opt)

keymap("x", "<M-down>", ":move '>+1<CR>gv-gv", opt)
keymap("x", "<M-up>",   ":move '<-2<CR>gv-gv", opt)


-- Terminal −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
keymap('t', '<ESC>', '<C-\\><C-n>', opt)

-- Clipboard −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
-- Faits avec Kitty
keymap('',  '<C-y>',		'"+y', opt)		-- Copy nvim to desk clipboard
-- keymap('n', '<C-P>',		'"*p', opt)		-- Past from desk to nvim

keymap('n', '<leader>p',	'"1p', opt)
keymap('n', '<leader>P',	'"2p', opt)
keymap('n', '<leader>y',	':Telescope registers<CR>', opt)

-- Window −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
keymap('n', '<S-left>',		':vertical resize -2<CR>', opt)
keymap('n', '<S-down>',		':resize -2<CR>', opt)
keymap('n', '<S-up>',		':resize +2<CR>', opt)
keymap('n', '<S-right>',	':vertical resize +2<CR>', opt)

keymap('n', '<C-left>',		'<C-w>h<CR>', opt)
keymap('n', '<C-down>',		'<C-w>j<CR>', opt)
keymap('n', '<C-up>',		'<C-w>k<CR>', opt)
keymap('n', '<C-right>',	'<C-w>l<CR>', opt)

-- TELESCOPE −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
-- Recherche dossier courant
keymap('n', '<leader>ff',	'<cmd>lua FindFiles_Current()<CR>', opt)
keymap('n', '<leader>fF',	'<cmd>lua FindFiles_1()<CR>', opt)
keymap('n', '<leader>Ff',	'<cmd>lua FindFiles_2()<CR>', opt)
keymap('n', '<leader>FF',	'<cmd>lua FindFiles_3()<CR>', opt)

-- Recherche home
keymap('n', '<leader>fç',	'<cmd>lua FindFiles_Home(false)<CR>', opt)
keymap('n', '<leader>fÇ',	'<cmd>lua FindFiles_Home(true)<CR>', opt)

-- Old files
keymap('n', '<leader>fo',   ':Telescope oldfiles <CR>', opt)

-- Recherche dossier
keymap('n', '<leader>fr',	'<cmd>lua require "telescope".extensions.file_browser.file_browser() <CR>', opt)
keymap('n', '<leader>fR',	'<cmd>lua require "telescope".extensions.file_browser.file_browser({hidden=true}) <CR>', opt)

-- Grep
keymap('n', '<leader>fg',	'<cmd>lua require("telescope.builtin").live_grep() <CR>', opt)
keymap('n', '<leader>fG',	'<cmd>lua liveGrep_Home() <CR>', opt)
keymap('n', '<leader>fs',	'<cmd>lua require("telescope.builtin").grep_string() <CR>', opt)

--
keymap('n', '<leader>fb',	'<cmd>lua require("telescope.builtin").buffers() <CR>', opt)
keymap('n', '<leader>fH',	'<cmd>lua require("telescope.builtin").help_tags() <CR>', opt)

--
keymap('n', '<leader>fh',	'<cmd>lua require("telescope.builtin").highlights() <CR>', opt)
keymap('n', '<leader>fm',	'<cmd>lua require("telescope.builtin").marks() <CR>', opt)

-- VIMUX −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
keymap('n', '<leader>vb',	':call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>', opt)
keymap('n', '<leader>vp',	':VimuxPromptCommand<CR>', opt)
keymap('n', '<leader>vl',	':VimuxRunLastCommand<CR>', opt)

keymap('n', '<leader>vc',	':VimuxCloseRunner<CR>', opt)
keymap('n', '<leader>vC',	':VimuxClearTerminalScreen<CR>', opt)
keymap('n', '<leader>vx',	':VimuxInterruptRunner<CR>', opt)

keymap('n', '<leader>vi',	':VimuxInspectRunner<CR>', opt)
keymap('n', '<leader>vz',	':VimuxZoomRunner<CR>', opt)

-- HOP −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
keymap('', '.',                 '<cmd>HopWord<CR>', opt)
keymap('', '<leader>.',         '<cmd>HopChar1<CR>', opt)
keymap('', '<space>',           '<cmd>HopLine<CR>', opt)
keymap('', '<leader><space>',   '<cmd>HopLineStart<CR>', opt)

-- LSPCONFIG −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
keymap('n', 'gD',             '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gd',             '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gi',             '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

keymap('n', 'K',              '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<C-k>',          '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

keymap('n', '<leader>wa',     '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
keymap('n', '<leader>wr',     '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
keymap('n', '<leader>wl',     '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
keymap('n', '<leader>D',      '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', '<leader>rn',     '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>ca',     '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', 'gr',             '<cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', '<leader>ft',     '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<leader>e',           '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d',                  '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d',                  '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q',           '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- TROUBLE −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
keymap("n",     "<leader>xx",   "<cmd>Trouble<cr>", opts)
keymap("n",     "<leader>xw",   "<cmd>Trouble workspace_diagnostics<cr>", opts)
keymap("n",     "<leader>xd",   "<cmd>Trouble document_diagnostics<cr>", opts)
keymap("n",     "<leader>xl",   "<cmd>Trouble loclist<cr>", opts)
keymap("n",     "<leader>xq",   "<cmd>Trouble quickfix<cr>", opts)
keymap("n",     "gR",           "<cmd>Trouble lsp_references<cr>", opts)
