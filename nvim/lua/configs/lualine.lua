-- Statusline (lualine): one bar for all windows, NvChad layout with powerline arrows
-- Parts are lualine's built-in names; see all of them: https://github.com/nvim-lualine/lualine.nvim#available-components
-- <space>up (path from the working dir ↔ file name) changes this config from mappings.lua
-- ─────────────────────────────────────────────────────────────────────────────

-- ─────────────────────────────────────────────────────────────── Helpers ────

-- Added / changed / removed line counts of the buffer, from gitsigns (no second git call)
-- nil outside a git repo: lualine then hides the part
local function gitsigns_diff()
  local g = vim.b.gitsigns_status_dict
  if g then return { added = g.added, modified = g.changed, removed = g.removed } end
end

-- Same icons as the sign column (configs/lspconfig.lua), for the file and the project counts
local diagnostic_symbols = { error = " ", warn = " ", info = " ", hint = " " }

-- True when other files have diagnostics too: the project counts are hidden when they'd repeat the file's
local function diagnostics_elsewhere()
  local function total(counts)
    local n = 0
    for _, count in pairs(counts) do
      n = n + count
    end
    return n
  end
  return total(vim.diagnostic.count()) > total(vim.diagnostic.count(0))
end

-- Encoding and line endings, only when unusual (not UTF-8, BOM, not Unix): "latin1", "dos"…
-- Empty for the usual files: lualine then hides the part
local function unusual_file_format()
  local parts = {}
  local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
  if encoding ~= "utf-8" then table.insert(parts, encoding) end
  if vim.bo.bomb then table.insert(parts, "bom") end
  if vim.bo.fileformat ~= "unix" then table.insert(parts, vim.bo.fileformat) end
  return table.concat(parts, " ")
end

-- Register a macro is being recorded into (qq → "@q"); shortmess "q" (options.lua) hides Neovim's own "recording @q"
local function macro_recording()
  local register = vim.fn.reg_recording()
  if register ~= "" then return " @" .. register end -- record icon
  return ""
end

-- ─────────────────────────────────────────────────────────────────────────────
return {
  options = {
    theme = "auto", -- follows :colorscheme (theme_menu, <space>ut)
    globalstatus = true, -- one bar for all windows (laststatus = 3)
    section_separators = { left = "", right = "" }, -- powerline arrows: left side points right, right side points left
    component_separators = { left = "", right = "" }, -- thin arrows between parts of one section
    disabled_filetypes = { statusline = { "snacks_dashboard" } },
  },

  sections = {
    -- ───────────────────────────────────────────────────────── Left side ────
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" }, -- git branch icon (Codicons, like every icon of the bar)
      {
        "diff",
        source = gitsigns_diff,
        symbols = { added = " ", modified = " ", removed = " " }, -- git diff icons
      },
    },
    lualine_c = {
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }, -- file icon
      { "filename", path = 1 }, -- 1 = path from the working dir, 0 = name only (<space>up)
      unusual_file_format, -- "latin1", "dos"… only when the file isn't UTF-8 / Unix
    },
    -- ──────────────────────────────────────────────────────── Right side ────
    lualine_x = {
      macro_recording, -- "@q" with a record icon while recording a macro
      { "%S", separator = "" }, -- pending keys (showcmdloc = "statusline" in options.lua): counts, "a, ms…, selection size in Visual mode
    },
    lualine_y = { -- grey: this file < servers < project
      {
        "diagnostics",
        sources = { "nvim_diagnostic" }, -- this file
        symbols = diagnostic_symbols,
        icon = " ", -- file: tells the file counts from the project's
      },
      "lsp_status", -- servers of the buffer, spinner while they work, ✓ when done
      {
        "diagnostics",
        sources = { "nvim_workspace_diagnostic" }, -- every file the language servers checked
        symbols = diagnostic_symbols,
        icon = " ", -- root folder: tells the project counts from the file's
        cond = diagnostics_elsewhere,
      },
    },
    lualine_z = { "location", "progress" }, -- line:column, percentage through the file
  },

  -- ───────────────────────────────────────────────────── Special windows ────
  -- Short bars for special windows (alphabetical)
  extensions = { "lazy", "man", "mason", "quickfix" },
}
