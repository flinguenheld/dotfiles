# Neovim setup log

Log of how this config was built from the NvChad v2.5 starter (coming from Helix).
It is for continuing the setup, and for rebuilding it without NvChad if needed.

- Started: 2026-11-16
- Neovim 0.12.6, NvChad v2.5, Fedora (rpm-ostree), terminal: WezTerm, login shell: fish
- Leader key: `<space>`

## Working rules

- Talk through each change first, and edit only after the go-ahead.
- One shortcut per action: when a key is added, the NvChad or Neovim key doing
  the same thing is removed (`del(...)` in `mappings.lua`).
- Plain one-line commands in the config: no loops, no helper functions.
- Each file starts with a 3-line description and a `─` separator.
- Lists are kept in alphabetical order.

## File layout

| File | Contents |
|---|---|
| `init.lua` | NvChad starter entry point (unchanged except its header) |
| `lua/chadrc.lua` | NvChad UI: theme `onedark`, base46 integrations `flash`, `snacks`, `todo` |
| `lua/options.lua` | editor options (Helix settings) |
| `lua/autocmds.lua` | trim on save, don't continue comments |
| `lua/mappings.lua` | all shortcuts, one section per topic |
| `lua/plugins/init.lua` | extra plugins + plugins turned off |
| `lua/configs/conform.lua` | formatters, format on save |
| `lua/configs/flash.lua` | flash modes |
| `lua/configs/lspconfig.lua` | LSP: NvChad defaults, diagnostics style, per-server settings, server list |
| `lua/configs/mason.lua` | packages installed automatically (mason-tool-installer) |
| `lua/configs/snacks.lua` | enabled snacks modules |
| `lua/configs/todo.lua` | todo-comments keywords (the Helix groups) |
| `lua/configs/treesitter.lua` | parsers for `:TSInstallAll` (47 active, 29 commented) |
| `lua/configs/whichkey.lua` | which-key group labels |
| `.stylua.toml` | `column_width = 150`, `collapse_simple_statement = "Always"` |

## Steps, in order

1. **Arrows instead of hjkl**
   - Removed NvChad's `Ctrl-hjkl` in Normal and Insert mode.
   - `j` and `l` turned off in Normal mode; `h` and `k` were reused later.
   - Arrows turned off in Insert mode.
   - `Ctrl-arrows` switch window (also from a terminal); `Ctrl-w Ctrl-arrows` move the window to that side.
   - `Alt-←/→` previous / next buffer.
2. **Treesitter**
   - NvChad's `:TSInstallAll` reads `ensure_installed` only when `opts` is a table, so `configs/treesitter.lua` returns one.
   - nvim-treesitter is on its `main` branch: installing parsers is separate from highlighting.
   - Neovim 0.12 ships c, lua, markdown, markdown_inline, query, vim, vimdoc.
   - **`:TSInstallAll` has not been run yet.**
3. **Mason + mason-tool-installer**
   - `lazy = false`, because it has to load before VimEnter.
   - It uses Mason names (`rust-analyzer`), while lspconfig uses its own names (`rust_analyzer`).
   - NvChad puts Mason's `bin` first in Neovim's PATH, so Mason's copies win over cargo/rustup ones.
4. **LSP + format on save, for Rust**
   - rust_analyzer runs with `check.command = "clippy"`.
   - conform runs `rustfmt` and `stylua` on save (`event = "BufWritePre"` in `plugins/init.lua`), with `lsp_format = "fallback"`.
5. **File headers** added to every file.
6. **snacks.nvim** with picker + lazygit; Telescope turned off (`enabled = false`).
   - The base46 integration needs `dofile(vim.g.base46_cache .. "<name>")` in the plugin's `config`.
   - After adding an integration, the theme cache has to be rebuilt once: `:lua require("base46").load_all_highlights()`.
7. **Shortcut groups**, see the reference below:
   - search `<space>s`, goto `g…`, code `<space>c` (first `<space>l`, moved because of where `l` is on the keyboard), git `<space>g`
   - `configs/whichkey.lua` created for the group labels.
8. **lua_ls knows snacks**: snacks added to the `library` list in `lspconfig.lua`. It removes the `Undefined global Snacks` warnings and gives completion.
9. **NvChad's LSP buffer keys turned off**
   - `require("nvchad.configs.lspconfig").on_attach = function() end`
   - This removes `gd`, `gD`, `<space>D`, `<space>ra`, `<space>wa/wr/wl`.
10. **Editor options from Helix** (`options.lua`):
    - `scrolloff = 10`, `relativenumber`, `colorcolumn = "80"`
    - `cursorlineopt = "both"`, `winborder = "single"`
    - `list` on; the custom `listchars` is commented out, so Neovim's default characters are used
    - `guicursor`: Visual mode = underline. **Note:** this line is no longer in `options.lua`; it was removed after being added.
    - The mouse was kept on, and the theme left unchanged for now.
11. **Autocommands from Helix** (`autocmds.lua`):
    - before saving, trim trailing spaces and empty lines at the end of the file (this applies to Markdown too)
    - remove `r` and `o` from `formatoptions`, so comments don't continue onto the next line
12. **Diagnostics like Helix** (`lspconfig.lua`, after `defaults()` because NvChad sets its own):
    - `virtual_text = { current_line = false }`: message at the end of the other lines
    - `virtual_lines = { current_line = true }`: full message under the cursor line
13. **flash.nvim**
    - `s`, `S`, `r` (operator), `R`; enhanced `f/F/t/T`.
    - Labels in `/` searches are off.
14. **todo-comments**
    - The Helix `<space>t` groups are 5 main keywords with alternatives, replacing the defaults (`merge_keywords = false`).
    - A colon is required (`TODO:`).
    - The pickers read their keyword lists from `configs/todo.lua`, so the lists are written only once.
15. **Undo / redo**: `U` = redo; `Ctrl-r` turned off in Normal mode.
16. **Registers picker** on `<space>sR`.
17. **More snacks modules:**
    - bigfile, dashboard, dim, explorer, image, input, notifier, quickfile, scope, statuscolumn, toggle, words
    - nvim-tree turned off; nvdash was already off.
18. **Buffer group** `<space>b`.
19. **Comments on `h`**
    - `h` is the operator and `hh` the current line, calling Neovim's built-in `vim._comment` directly.
    - `gc` / `gcc` and NvChad's `<space>/` removed.
    - `gc` in operator mode (comment text object) is kept.
20. **Cheatsheet** moved to `<space>?`; NvChad's themes moved to `<space>ut`.

## Shortcut reference

### Without leader

| Key | Action |
|---|---|
| `j`, `l` | off (use the arrows) |
| `h` / `hh` / `h` (Visual) | comment operator / line / selection |
| `k` | LSP hover |
| `K` | Vim help (`man` outside Vim files); mapped to itself so Neovim doesn't replace it with hover |
| `Ctrl-k` (Normal + Insert) | LSP signature help |
| `gd` `gD` `gr` `gi` `gy` | definition, declaration, references, implementation, type definition (snacks pickers) |
| `]d` `[d` `]D` `[D` `Ctrl-w d` | diagnostics (Neovim defaults) |
| `]g` / `[g`, `ig` | next / previous git hunk, hunk text object |
| `]t` / `[t` | next / previous todo comment |
| `]r` / `[r` | next / previous LSP reference (snacks words) |
| `ii` / `ai`, `[i` / `]i` | indentation-block text objects and jumps (snacks scope) |
| `s` `S` `r` `R` | flash |
| `U` | redo |
| `Ctrl-arrows`, `Alt-←/→` | windows, buffers |
| `Tab` / `Shift-Tab` | next / previous buffer (NvChad, still active) |

### Leader groups

| Group | Keys |
|---|---|
| `<space>b` buffers | `bq` close current, `ba` close all others, `bs` search buffers |
| `<space>c` code (LSP) | `cs`/`cS` symbols, `cc`/`cC` incoming/outgoing calls, `cd`/`cD` diagnostics, `cr` rename, `ca` code actions, `cf` format, `ce` line diagnostic, `cl` code lens |
| `<space>g` git | `gg` lazygit, `gs` status, `gl` log, `gf` file log, `gL` line log, `gb` branches, `gd` diff, `gS` stash, `gp` preview hunk, `ga`/`gr` stage/reset hunk (or selection), `gA`/`gR` stage/reset file, `gB` blame line, `gD` diffthis, `go` open in browser |
| `<space>s` search | `sf` files, `sF` + hidden, `sa` all, `sr` recent, `sg` grep, `sw` word/selection, `sl` lines, `sh` help, `sk` keymaps, `sc` commands, `sm` marks, `sj` jumps, `su` undo, `sR` registers, `sn` notifications, `sq` quickfix, `ss` resume, `sp` pickers |
| `<space>t` todo | `ta` all, `tt` TODO, `ti` NOTE, `tw` WARN, `te` FIX, `th` HINT |
| `<space>u` ui | `ut` themes, `un` dismiss notifications; toggles: `ub` git blame, `ud` diagnostics, `uD` dim, `uh` inlay hints, `ul` numbers, `uL` whitespace, `ur` relative numbers, `us` spell, `uT` Treesitter, `uw` wrap |
| single keys | `<space>e` explorer, `<space>?` cheatsheet |

## Removed NvChad / Neovim defaults

- **NvChad:**
  - `Ctrl-h/j/k/l` (Normal + Insert)
  - `<space>ff fa fw fb fo fz fh ma cm gt pt`
  - `<space>ds fm`, `<space>n rn ch /`, `<space>b`, `<space>x`, `Ctrl-n`
  - the LSP buffer keys (`on_attach` replaced)
- **Neovim:**
  - `grn gra grx grr gri grt gO`
  - `Ctrl-s` (Insert/Select), `gc`/`gcc` (Normal/Visual), `Ctrl-r` (Normal)
- **Plugins turned off:** telescope.nvim, nvim-tree.lua. Their files are still on disk; `:Lazy clean` removes them.

## What still depends on NvChad (to replace if leaving it)

| NvChad part | Used for | Possible replacement |
|---|---|---|
| base46 | theme + plugin colours, `<space>ut`, the `dofile(vim.g.base46_cache …)` lines | a theme plugin (catppuccin has frappe) |
| statusline | mode, git, diagnostics, LSP progress | lualine |
| tabufline | buffer bar; `<space>bq`/`ba`, `Alt-←/→`, `Tab` | bufferline + `Snacks.bufdelete` |
| nvchad.term | `Alt-h`, `Alt-v`, `Alt-i` terminals | snacks terminal |
| completion | nvim-cmp + LuaSnip + friendly-snippets + autopairs | blink.cmp |
| nvchad.lsp.renamer | `<space>cr` popup | `vim.lsp.buf.rename` + snacks input |
| NvCheatsheet | `<space>?` | `<space>sk` keymaps picker |
| `nvchad.options` / `nvchad.autocmds` | default options, Treesitter start on FileType, the `User FilePost` event | copy the parts that are needed |
| `nvchad.configs.lspconfig.defaults()` | capabilities, diagnostic icons, lua_ls settings | write them in `lspconfig.lua` |
| plugins set up by NvChad | gitsigns, indent-blankline, mason, conform, Treesitter, which-key, devicons, menu/minty/volt | list them in `plugins/init.lua` |

## Gotchas found

- A new base46 integration fails to load (`cannot open …/base46/<name>`) until the theme cache is rebuilt.
- `vim.keymap.del` errors at startup if the key no longer exists, for example if an NvChad update renames it.
- In headless tests, NvChad loads the LSP only after `UIEnter`, so tests need `doautocmd UIEnter`.
- which-key doesn't list text objects after `h` (or after `gc`): those aren't keys under `h`. Press `y` or `d` and wait to see them.
- `K` uses `man` in Lua files: Neovim only sets `keywordprg=:help` for Vim script.
- In Rust files, `]]` / `[[` are Rust's own keys (jump between functions), which is why snacks words is on `]r` / `[r`.

## Still to do

- Run `:TSInstallAll`; run `:checkhealth snacks` in WezTerm to see image support.
- The other Helix languages:
  - Python (ty, ruff)
  - Haskell (hls)
  - Markdown (harper-ls, dprint)
  - TOML (taplo with the schema workaround, crates-lsp)
  - JSON/CSS (biome)
  - HTML
  - KDL
  - Bash (shfmt, no format on save)
  - uwu_colors
  - per-language rulers (rust/python at 79)
- NvChad terminals vs snacks terminal.
- Later:
  - trouble.nvim, crates.nvim, nvim-dap
  - yanky (yank history)
  - snacks scratch
  - customising the dashboard
  - the theme (frappe)
- Tidy the goto (`g`) section.
- Optional:
  - add `h` to which-key's operator list (needs testing in a real Neovim window)
  - `Ctrl-s` for flash labels in `/` searches
