-- Autocommands: code that runs on events (save, filetype…)
-- Loaded from init.lua after the plugins
-- See :h autocmd-events for the list of events
-- ─────────────────────────────────────────────────────────────────────────────

local autocmd = vim.api.nvim_create_autocmd

-- ────────────────────────────────────────────────────────── Trim on save ────

-- Before saving: remove spaces at line ends and empty lines at the end of the file
-- (like Helix trim-trailing-whitespace + trim-final-newlines; formatters often do it too)
autocmd("BufWritePre", {
  callback = function()
    if not vim.bo.modifiable then return end -- e.g. saving :checkhealth output with :w
    local view = vim.fn.winsaveview()
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.cmd [[keeppatterns %s/\n\+\%$//e]]
    vim.fn.winrestview(view)
  end,
})

-- ────────────────────────────────────────────────── Comment continuation ────

-- Don't continue comments on the next line (Enter in Insert mode, o / O), like Helix continue-comments = false
-- Done on FileType because each file type sets its own formatoptions
autocmd("FileType", {
  callback = function() vim.opt_local.formatoptions:remove { "r", "o" } end,
})

-- ──────────────────────────────────────────────────────────── Treesitter ────

-- Treesitter: highlighting, and indent like Helix, for each file type that has a parser
-- pcall: file types without a parser keep Neovim's regex highlighting
-- Indent only where the language has an indent query; elsewhere Neovim's own indent stays
autocmd("FileType", {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then return end
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if vim.treesitter.query.get(lang, "indents") then vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end,
})

-- ────────────────────────────────────────────────────────── Search count ────

-- Search count at the end of the line, like "[2/5]", when the cursor is on a match (after *, #, n, N, /…)
-- Hidden once the cursor leaves the match, after :nohlsearch, or in Insert mode
-- shortmess "S" (options.lua) keeps Neovim from also printing it in the command line
local search_ns = vim.api.nvim_create_namespace "search_count"
local search_buf -- buffer that shows the count, so it can be cleared from another one

local function clear_search_count()
  if search_buf and vim.api.nvim_buf_is_valid(search_buf) then vim.api.nvim_buf_clear_namespace(search_buf, search_ns, 0, -1) end
  search_buf = nil
end

autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
  callback = function(args)
    clear_search_count()
    if args.event ~= "CursorMoved" or vim.v.hlsearch == 0 then return end
    local ok, count = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 100 })

    -- current / total can be missing (e.g. the search timed out): show nothing then
    if not ok or not count.current or not count.total or count.total == 0 or count.exact_match == 0 then return end

    local total = count.incomplete == 2 and ">" .. count.maxcount or count.total
    search_buf = args.buf
    vim.api.nvim_buf_set_extmark(args.buf, search_ns, vim.fn.line "." - 1, 0, {
      virt_text = { { ("[%d/%s]"):format(count.current, total), "DiagnosticVirtualTextInfo" } }, -- color: any group from :lua Snacks.picker.highlights()
      virt_text_pos = "eol",
    })
  end,
})

-- ───────────────────────────────────────────────────────── Resize splits ────

-- Terminal resized (e.g. by Niri): share the space equally again between splits, in every tab
-- Neovim's equalalways only does it when a split opens or closes; a split resized by hand goes back to equal too
autocmd("VimResized", {
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. tab)
  end,
})

-- Snacks explorer opened: it takes its width from the window next to it only, so share the rest equally again
-- (its own width is fixed, so it keeps it; closing it already re-balances by itself)
autocmd("FileType", {
  pattern = "snacks_layout_box",
  callback = function()
    vim.schedule(function() vim.cmd "wincmd =" end)
  end,
})
