# Neovim build plan

Plan for building this Neovim config from scratch: every plugin, option and shortcut is chosen.
Written on 2026-11-17.

## Working rules

- Talk through each step first, and edit only after the go-ahead.
- One shortcut per action: when a key replaces a Neovim default, the default is removed (`del(...)`).
- Mappings: one plain `map()` line per key, no loops. Helper functions are welcome elsewhere.
- Each Lua file starts with a 3-line description and a `─` separator.
- Lists are kept in alphabetical order.
- Each step ends with Neovim starting without errors, and is tested before the next one.

## How plugins are chosen

1. **snacks.nvim first**: if snacks has a module for it, use that.
2. **mini.nvim only when that module is recognised as the better choice** (so far: mini.ai, mini.icons).
3. Otherwise, the plugin the community recognises as the reference.
4. Completion: **blink.cmp**.
5. Nothing is installed "just in case": each plugin has a reason in the list below.

## Plugin list

| Area | Plugin | Why |
|---|---|---|
| Base | `folke/lazy.nvim` | plugin manager (lazydev and snacks assume it) |
| Base | `folke/snacks.nvim` | picker, explorer, dashboard, notifier, indent, scope, words, input, bufdelete, lazygit, gitbrowse, rename, toggle, statuscolumn, image, dim, bigfile, quickfile |
| UI | `akinsho/bufferline.nvim` | buffer bar, shown only with 2+ buffers (like Helix `bufferline = "multiple"`) |
| UI | `folke/which-key.nvim` | key hints; shows the state of snacks toggles |
| UI | `nvim-lualine/lualine.nvim` | statusline (mode, git, diagnostics, LSP progress) |
| UI | `nvim-mini/mini.icons` | icons; also stands in for nvim-web-devicons (bufferline needs that) |
| Themes | `catppuccin/nvim`, `ellisonleao/gruvbox.nvim`, `sainnhe/everforest`, `Shatur/neovim-ayu` | see "Themes" below |
| Editing | `folke/flash.nvim` | jumps, enhanced `f/t` |
| Editing | `folke/todo-comments.nvim` + `nvim-lua/plenary.nvim` | TODO highlights, `]t`/`[t`, `<space>t` pickers |
| Editing | `kylechui/nvim-surround` | surround; its keys `ys`/`cs`/`ds` don't clash with flash's `s` |
| Editing | `MagicDuck/grug-far.nvim` | search and replace across files |
| Editing | `nvim-mini/mini.ai` | `a`/`i` text objects: function, class, argument, call, quotes… |
| Editing | `windwp/nvim-autopairs` | auto brackets, Treesitter-aware |
| Code | `folke/lazydev.nvim` | lua_ls knows the config and plugins (replaces the hand-written `library` list) |
| Code | `mason-org/mason.nvim` + `WhoIsSethDaniel/mason-tool-installer.nvim` | installs LSP servers and formatters |
| Code | `neovim/nvim-lspconfig` | server settings, used through `vim.lsp.config` / `vim.lsp.enable` |
| Code | `nvim-treesitter/nvim-treesitter` (`main` branch) | parsers, highlighting |
| Code | `nvim-treesitter/nvim-treesitter-textobjects` | `]f` `]a` `]t` `]h` jumps; queries used by mini.ai |
| Code | `saghen/blink.cmp` + `rafamadriz/friendly-snippets` | completion + snippets |
| Code | `stevearc/conform.nvim` | format on save |
| Colours | `brenoprata10/nvim-highlight-colors` | colour squares for hex, `rgb()`, `hsl()`, CSS variables; also in blink's menu |
| Git | `lewis6991/gitsigns.nvim` | signs, hunks, blame, staging (+ snacks lazygit) |

### Left out, and why

- **mini modules:** snacks does it (animate, bufremove, cursorword, files, indentscope, input, notify,
  pick/extra/fuzzy, starter, statuscolumn, visits); Neovim or this config does it (basics, bracketed,
  comment, trailspace, cmdline); another plugin is better (jump/jump2d → flash, clue → which-key,
  completion/snippets → blink, diff/git → gitsigns, hipatterns → todo-comments + highlight-colors,
  statusline → lualine, tabline → bufferline, pairs → autopairs, sessions → persistence, deps → lazy);
  only for theme/plugin authors (base16, colors, hues, doc, test, misc, keymap, map).
- **Other common plugins:** nvim-cmp + sources and LuaSnip (→ blink), indent-blankline (→ snacks indent),
  nvim-web-devicons (→ mini.icons), telescope and fzf-lua (→ snacks picker), nvim-tree and neo-tree
  (→ snacks explorer), mason-lspconfig (→ mason-tool-installer + explicit `vim.lsp.enable`).
- **Multiple cursors:** not in Neovim core. Use `*` + `cgn` + `.`, `:s`, Visual-block, grug-far.
- **noice.nvim, nvim-lint, ts-comments, nvim-ts-autotag:** not needed now (ts-autotag comes back with HTML).

## Themes

The theme menu script `~/.config/theme/theme_menu` writes the theme name to `~/.config/theme/palette.toml`
(`theme="catppuccin_frappe"`, via `theme_make_palette`), then runs `pkill -USR1 nvim`. Neovim reads the name
from that file; the script no longer edits the Neovim config (changed in step 5: its `sed` on
`colorscheme.lua` was removed).

`lua/plugins/colorscheme.lua` contains:

1. `get_theme()`: the name from the `theme="…"` line of `palette.toml`; `catppuccin_frappe` if the file is missing.
2. A table from the script's names to `{ Neovim colour scheme, background }`, for example
   `catppuccin_frappe = { "catppuccin-frappe", "dark" }`, `gruvbox_light = { "gruvbox", "light" }`.
3. At startup (`User LazyDone`): apply `get_theme()`. All four theme plugins are `lazy = true`: lazy.nvim loads
   the right one on the first `:colorscheme`.
4. `autocmd Signal SIGUSR1`: apply `get_theme()` again.
   (Tested: `pkill -USR1 nvim` reaches both Neovim processes; the autocommand runs once, in the editor.)
5. Check: a missing file or an unknown name gives a warning and the default theme; a colour scheme that
   fails to load gives a warning and keeps the current theme.
6. The plugin entries for the four theme families.

lualine (`theme = "auto"`) and bufferline follow `:colorscheme` by themselves.
Background: a colour scheme is a `colors/<name>.lua` file found in Neovim's runtime, the config, or a
plugin; `:colorscheme <name>` runs it. Neovim 0.12 ships `catppuccin` (latte/mocha only, no plugin colours).

## Shortcuts

### Base rules (decided)

- Leader: `<space>`.
- **hjkl are removed** in Normal, Visual and Operator-pending mode. The arrows do every move.
  - `j`, `l`: off in all three modes (kept free for later).
  - `h`: comment: operator in Normal (`hh` = line), current selection in Visual; off in Operator-pending.
  - `k`: LSP hover in Normal; off in Visual and Operator-pending.
  - `K`: Vim help, mapped to itself so Neovim doesn't turn it into hover.
- **Plugin windows** (explorer, picker list…): their hjkl keys are moved to arrows too, in each plugin's step.
- Arrows stop at the start and end of a line (`whichwrap` left at Neovim's default).
- Arrows are off in Insert mode.
- Windows: `Ctrl-arrows` go to the window on that side; `Ctrl-w Ctrl-arrows` move the window there.
- `U` = redo; `Ctrl-r` off in Normal mode.

### Still to discuss

1. Default keys of the new plugins: **decided during each plugin's step**, after trying them.
   Notes from the first discussion:
   - nvim-surround: Visual `S` clashes with flash's `S`; idea: Visual surround on `gs`.
   - mini.ai: letters lined up with Helix (`f` function, `t` type, `a` argument, `c` comment, `x` tag, `T` test, `u` call).
   - treesitter-textobjects (decided in step 8): `]f` function, `]a` argument, `]t` class/type, `]h` comment
     (`h` = comment key). `]c` = change everywhere (diff mode: Neovim's; otherwise git hunks, step 13).
     No `]T` (test): no language has a test query in the plugin.
   - blink: preset `default` (`Ctrl-y`), `super-tab` or `enter`; no `↑` `↓` in the menu (arrows are off in Insert).
   - grug-far: idea `<space>sr`, with recent files moved to `<space>s.`.
2. Neovim's own defaults (`gr*`, `[d` `]d`, `Ctrl-s` in Insert, `gc`): keep or replace, **decided during the steps**
   that touch them (step 4 for `gc`, step 10 for `gr*` and diagnostics, step 11 for `Ctrl-s`).
3. The leader groups: **decided during the steps**. The full reference table is written here as they're settled.

## Steps

| # | Step | Contents | To decide during the step |
|---|---|---|---|
| 0 ✓ | Backup and clean | user copies `~/.config/nvim`; empty the folder, keeping `SETUP-LOG.md`, `BUILD-PLAN.md`, `.stylua.toml` | also move `~/.local/share/nvim` and `~/.cache/nvim` (old plugins, Mason packages, caches)? keep `~/.local/state/nvim` (undo history)? |
| 1 ✓ | Skeleton | `init.lua`: leader key, lazy.nvim bootstrap, load the files below; `configs/lazy.lua` | — |
| 2 ✓ | Options | `options.lua`: the Helix options + common ones (clipboard, ignorecase/smartcase, undofile, splits, signcolumn, indent width…) | go through the options one by one |
| 3 ✓ | Autocommands | `autocmds.lua`: trim on save, `formatoptions` | — |
| 4 ✓ | Basic keys | `mappings.lua`: the base rules from "Shortcuts" (hjkl, arrows, windows, `U`, `h`, `k`, `K`); `<space>y` → `"+y` (Normal + Visual, Helix clipboard style); remove Neovim's `gc`/`gcc`, `Ctrl-r` and the built-in window keys (`gr*`, `gO` → step 10, `Ctrl-s` → step 11) | — |
| 5 ✓ | Themes | `plugins/colorscheme.lua` as described above; `theme_menu` only signals | Serika: warning + default theme; all theme plugins `lazy = true` |
| 6 ✓ | snacks + mini.icons | `configs/snacks.lua`; `<space>ut` = colorschemes picker (session only, the file stays the reference); `<space>s`, `<space>b`, `<space>u`, `<space>e` keys | icons `style = "ascii"` or glyphs |
| 7 ✓ | which-key | `configs/whichkey.lua`: group labels | `<space>?`: which-key or keymaps picker? `h` in the operator list? |
| 8 ✓ | Treesitter + textobjects | `configs/treesitter.lua`: parser list, start highlighting on FileType; `]f`/`[f` jumps; install the parsers | Treesitter indent? |
| 9 ✓ | Mason | `configs/mason.lua` | — |
| 10 ✓ | LSP + lazydev | `configs/lspconfig.lua`: capabilities from blink, diagnostics style + icons, lua_ls, rust_analyzer + clippy; `g…` and `<space>c` keys; rename via snacks input | — |
| 11 | Completion | blink.cmp + friendly-snippets, nvim-autopairs | one way to show signatures: blink or `Ctrl-k` |
| 12 | Format | `configs/conform.lua`, format on save | — |
| 13 | Git | gitsigns + `<space>g` keys, `]c`/`[c` hunks (Neovim's diff jump kept in diff mode), `ig` | — |
| 14 | flash | `configs/flash.lua`, as now | — |
| 15 | todo-comments | `configs/todo.lua`, as now, without `]t`/`[t` (class/type since step 8; the `<space>t` pickers do it) | — |
| 16 | Text objects, surround | mini.ai (with Treesitter function/class objects), nvim-surround | mini.ai keys vs snacks scope `ii`/`ai`; remove Op-pending `gc` (comment object) if mini.ai `c` replaces it; Neovim 0.12 `an`/`in`, `[n`/`]n` (Treesitter nodes) |
| 17 | grug-far | search and replace | key (`<space>sr` is taken by recent files) |
| 18 | Statusline | `configs/lualine.lua` | which sections |
| 19 | Buffer bar | `configs/bufferline.lua`; `Alt-←/→`, `Tab`, `<space>bq`/`ba` | keep both `Alt-←/→` and `Tab`? (one key per action); Neovim 0.12 `[b`/`]b` do the same |
| 20 | Colour squares | nvim-highlight-colors | — |
| 21 | Log | rewrite `SETUP-LOG.md` for the new config | — |

## Reference and gotchas

- The old config and its log (`SETUP-LOG.md`, with the old shortcut reference) are in `~/.config/nvim_bak`.
- A new `SETUP-LOG.md` is started at step 1 and filled in after each step.
- `K` uses `man` in Lua files: Neovim only sets `keywordprg=:help` for Vim script.
- In Rust files, `]]` / `[[` are Rust's own keys (jump between functions): that's why snacks words was on `]r` / `[r`.
- which-key doesn't list text objects after `h` (or after `gc`): press `y` or `d` and wait to see them.
- `vim.keymap.del` errors at startup if the key doesn't exist (e.g. a default renamed in a new Neovim version).

## Later (after the rebuild works like the current config)

- Languages from Helix: Python (ty, ruff), Haskell (hls), Markdown (harper-ls, dprint, render-markdown),
  TOML (taplo, crates-lsp, SchemaStore), JSON/CSS (biome), HTML (+ nvim-ts-autotag), KDL,
  Bash (shfmt, no format on save), per-language rulers.
- Plugins: trouble.nvim, crates.nvim, nvim-dap, yanky, persistence.nvim, guess-indent.nvim.
- Optional: mini.align (Helix `&`), treesj (split/join), mini.move.
- Terminal: none for now. `:terminal` is built into Neovim; a snacks toggle key (`Snacks.terminal`)
  can be added later, maybe with REPLs for Python/Haskell (sending code to `python` / `ghci`).
- snacks scratch, dashboard customisation, `:checkhealth snacks` in WezTerm (images).
- `Ctrl-s` for flash labels in `/` searches.
