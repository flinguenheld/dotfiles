# Neovim setup log

Log of the from-scratch config, following `BUILD-PLAN.md`.
The old NvChad config and its log are in `~/.config/nvim_bak`.

## Step 0: Backup and clean (2026-11-17)

- Old config copied to `~/.config/nvim_bak`; `~/.config/nvim` emptied (kept `BUILD-PLAN.md`, `.stylua.toml`).
- `~/.local/share/nvim` and `~/.cache/nvim` removed (old plugins, Mason packages, caches).
- `~/.local/state/nvim` kept (undo history).

## Step 1: Skeleton (2026-11-17)

Files:

- `init.lua`: leader and local leader = `<space>`; lazy.nvim bootstrap (cloned into
  `~/.local/share/nvim/lazy/lazy.nvim` on the first start, `stable` branch); `require("lazy").setup()`.
  No plugin spec yet: it becomes `{ { import = "plugins" } }` at the first plugin step.
- `lua/configs/lazy.lua`: lazy.nvim settings. Disabled built-in plugins: `gzip`, `netrwPlugin`
  (snacks explorer replaces it), `rplugin` (old Python/Node remote plugins), `tarPlugin`, `tutor`, `zipPlugin`.
  (`tohtml` is no longer a runtime plugin in Neovim 0.12, so it was dropped from the list.)

Layout: `lua/options.lua`, `lua/autocmds.lua`, `lua/mappings.lua` (steps 2–4), `lua/configs/*.lua`
(plugin settings), `lua/plugins/*.lua` (plugin specs).

Gotcha: the old NvChad list also disabled `ftplugin` and `syntax`; not done here, since they're needed
for filetype settings and for files without a Treesitter parser.

## Step 2: Options (2026-11-17)

`lua/options.lua`, loaded from `init.lua` right after the leader, before lazy.nvim. One option per line, alphabetical.

- From Helix: `colorcolumn = "80"`, `cursorline` + `cursorlineopt = "both"`,
  `list` + `listchars = "eol:↵,tab:→·"` (no `trail`/`nbsp` marks, like Helix), `number` + `relativenumber`,
  `scrolloff = 10`, `winborder = "single"`, `wrap = false`. Mouse kept on (`mouse = "a"`), unlike Helix.
- Clipboard: `clipboard = ""` (Helix style: `y`/`d`/`p` stay in Neovim; `<space>y` → `"+y` comes in step 4;
  paste from the system with WezTerm `Ctrl-Shift-V` or `"+p`). The other choices are written as comments.
- From NvChad's old defaults:
  `expandtab`, `shiftwidth`/`tabstop`/`softtabstop = 2`, `ignorecase` + `smartcase`, `laststatus = 3`,
  `showmode = false`, `signcolumn = "yes"`, `splitbelow`, `splitright`, `splitkeep = "screen"`,
  `timeoutlen = 400`, `undofile`, `updatetime = 250`; node/perl/python3/ruby providers off.
- New: `inccommand = "split"` (live preview of `:s`).
- `guicursor` with Visual = underline (Helix `select = "underline"`) is written but commented out: trying
  Neovim's default (block in Visual) for now.
- Not set, on purpose: `fillchars = "eob: "` (the `~` after the end of the file is kept), `confirm`
  (`:q` on an unsaved buffer gives an error, like Helix), `whichwrap` (Neovim's default), `smoothscroll`
  (no wrapping, so not needed).
- The `+` register on Wayland works through `wl-copy` (installed).
- Until lualine (step 18), the mode isn't shown anywhere (`showmode = false`).

## Step 3: Autocommands (2026-11-17)

`lua/autocmds.lua`, loaded from `init.lua` after lazy.nvim.

- `BufWritePre`: removes spaces at line ends and empty lines at the end of the file (Helix
  `trim-trailing-whitespace` + `trim-final-newlines`). The cursor and view are kept (`winsaveview`),
  and the search history isn't touched (`keeppatterns`). Applies to every file type, Markdown included
  (two trailing spaces as a line break are removed too).
- `FileType`: removes `r` and `o` from `formatoptions`, so Enter / `o` / `O` don't continue a comment
  (Helix `continue-comments = false`). Done per file type because each ftplugin sets its own `formatoptions`.
- Formatters (step 12) usually trim too; the autocommand covers files with no formatter, or when it fails.

## Step 4: Basic keys (2026-11-17)

`lua/mappings.lua`, loaded from `init.lua` after the autocmds. One `map()` / `del()` per line.

| Keys | Modes | Does |
|---|---|---|
| `j`, `l` | Normal, Visual, Op-pending | off (arrows instead) |
| `h` / `hh` | Normal (+ `h` in Visual) | comment operator / comment line (Neovim's `gc` / `gcc`); off in Op-pending |
| `k` | Normal | LSP hover; off in Visual and Op-pending |
| `K` | Normal | Vim help (mapped to itself so Neovim doesn't make it hover) |
| arrows, `Home`, `End`, `PageUp`, `PageDown` | Insert | off (like Helix) |
| `Ctrl-←↓↑→` | Normal | go to the window on that side |
| `Ctrl-w Ctrl-←↓↑→` | Normal | move the window to that side |
| `<space>y` | Normal, Visual | yank to the system clipboard (`"+y`) |
| `U` | Normal | redo |

Removed or turned off (one key per action):

- `gc` / `gcc` (Normal, Visual): `del()`, replaced by `h` / `hh`. `gc` in Op-pending (comment text
  object, `dgc`) is kept until mini.ai (step 16).
- `Ctrl-r`: `<Nop>`, replaced by `U`.
- Built-in window keys: `Ctrl-w h/j/k/l`, `Ctrl-w Ctrl-h/j/k/l`, `Ctrl-w BS`, `Ctrl-w ←↓↑→`,
  `Ctrl-w H/J/K/L` → `<Nop>`. The Ctrl-arrow mappings still work: a mapping's right-hand side is
  non-recursive, so it uses the built-in command, not the `<Nop>`.
- The `h` / `k` "off" lines are written but commented, pointing to their new job.

Decisions:

- Windows stay on `Ctrl-w` (like Helix, where `<space>w` was turned off); no `<space>w` group.
- `gr*`, `gO`, `Ctrl-s` (Insert, Select) are kept for now: removed in steps 10 / 11, which replace them.
- Terminal-mode window keys: later, when a terminal is added.
- Neovim 0.12 defaults noted in the plan for later steps: `[t`/`]t` (step 15), `an`/`in`, `[n`/`]n`
  (step 16), `[b`/`]b` (step 19).

Gotcha: with both `h` and `hh` mapped, Neovim waits `timeoutlen` (400 ms) after `h` only if you pause;
typing `hip` straight away works at once.

## Step 5: Themes (2026-11-17)

`lua/plugins/colorscheme.lua` (first plugin file: `init.lua` now loads `{ { import = "plugins" } }`).

- The theme name comes from `~/.config/theme/palette.toml` (`theme="…"`, written by `theme_make_palette`,
  which `theme_menu` runs first). `get_theme()` reads it and always returns a name from the table: missing
  file, no `theme="…"` line, or unknown name (Serika) → warning (`warn()` helper) + `catppuccin_frappe`.
- `themes` table: theme_menu name → `{ colour scheme, background }` for ayu (light, mirage), catppuccin
  (frappe, latte, macchiato, mocha), everforest (dark, light), gruvbox (dark, light).
- `apply(name)`: sets `background`, then `:colorscheme`. A scheme that fails to load: warning, current
  theme kept (background restored).
- Startup: `User LazyDone` autocommand applies `get_theme()`. `SIGUSR1`: applies `get_theme()` again.
  Both in the `theme` augroup with `clear = true` (lazy.nvim re-reads the file when it changes).
- Plugins, all `lazy = true` (lazy.nvim loads the right one on `:colorscheme`): `Shatur/neovim-ayu`,
  `catppuccin/nvim` (`auto_integrations = true`), `ellisonleao/gruvbox.nvim`, `sainnhe/everforest`
  (the last three have no integration setting; they cover common plugins by default).
- `configs/lazy.lua`: `change_detection = { notify = true }` (lazy.nvim's default, written out): when a file
  in `lua/plugins/` changes, lazy.nvim re-reads the plugin list (`:Lazy` shows new plugins) and says so. It
  doesn't re-apply running plugins or the other config files: restart for that.
- `~/.config/theme/theme_menu` changed: `NVIM_FILE` / `NVIM_REG` and the `sed` on `colorscheme.lua` removed;
  only `pkill -USR1 nvim 2>/dev/null` is left. The config folder is no longer edited by a script.

Tested: startup theme; SIGUSR1 after changing `palette.toml` to gruvbox light, everforest dark, ayu light,
and back; Serika at startup and on the signal, no `theme=` line, no `palette.toml` → warning + catppuccin frappe.

Gotchas:

- Autocommands need `nested = true` to run `:colorscheme` from a callback: without it, `ColorSchemePre`
  (lazy.nvim's plugin loader) and `ColorScheme` (lualine, bufferline) don't fire, and you get
  `E185: Cannot find color scheme`.
- Reading the theme from a variable in a lazy.nvim spec file doesn't work for the signal: lazy.nvim only
  re-reads changed files every 2 s, after the signal has arrived.
- neovim-ayu sets `g:colors_name = "ayu"` for every variant.
- `<space>ut` (colorschemes picker) comes with snacks in step 6: a theme picked there lasts for the session only.

## Step 6: snacks + mini.icons (2026-11-17)

Files:

- `lua/plugins/init.lua` (new): plugin list. `folke/snacks.nvim` (`lazy = false`, `priority = 1000`,
  opts from `configs/snacks.lua`); `nvim-mini/mini.icons` (`lazy = false`, `style = "glyph"`, the `"ascii"`
  line commented; `mock_nvim_web_devicons()` so plugins asking for nvim-web-devicons get mini.icons).
- `lua/configs/snacks.lua`: modules switched on: bigfile, dashboard, explorer, image, indent (guides on every
  level), input, notifier, picker, scope, statuscolumn, words. `quickfile` written but commented out.
  Function-only modules (no setup): bufdelete, dim, gitbrowse, lazygit, rename, toggle.
- Picker keys: `j`/`k` and `Ctrl-j`/`Ctrl-k` off in the input and list windows (arrows move, `Ctrl-d`/`Ctrl-u`
  scroll). Explorer: `h`/`l` off, `Enter` opens a file or opens/closes a folder (no arrows).

Keys (`lua/mappings.lua`):

| Keys | Does |
|---|---|
| `<space>sf` `sF` `sa` `sr` | files, + hidden, all (hidden + ignored), recent |
| `<space>sg` `sw` `sl` | grep, grep word / selection, lines in file |
| `<space>sh` `sk` `sc` `sm` `sj` `su` `sR` | help, keymaps, commands, marks, jumps, undo history, registers |
| `<space>sn` `sq` `ss` `sp` | notifications, quickfix, resume last picker, all pickers |
| `<space>bq` `ba` `bs` | close buffer (keeps window), close all others, search buffers |
| `<space>e` / `<space>E` | explorer open/close / go to the explorer (opens it if closed) |
| `<space>un` `ut` | dismiss notifications, colour schemes (session only) |
| `<space>ud` `uD` `uh` `ul` `uL` `ur` `us` `uw` | toggles: diagnostics, dim, inlay hints, line numbers, whitespace, relative numbers, spell, wrap |
| `]r` / `[r` | next / previous LSP reference (snacks words) |
| `ii` / `ai`, `[i` / `]i` | indent-scope text objects and jumps (snacks scope, set by snacks itself) |

Tested: startup without errors; `vim.notify` goes to the snacks history; nvim-web-devicons resolves to
mini.icons; picker input has `↓`/`Ctrl-d` but no `Ctrl-j`, list has no `j`; explorer list has `Enter`, no `h`/`l`;
`<space>E` moves into an open explorer.

Gotchas:

- Picker key overrides must be spelled like snacks' defaults (`"<c-j>"`, lowercase) to replace them.
- The picker input is in Insert mode, but its arrows work: snacks' buffer-local keys win over the global
  "no arrows in Insert" mappings.
- `Snacks.explorer()` toggles: a second call closes the explorer, hence `<space>E` to go into it.

## Step 7: which-key (2026-11-17)

- `lua/plugins/init.lua`: `folke/which-key.nvim`, `event = "VeryLazy"`, opts from `configs/whichkey.lua`.
- `lua/configs/whichkey.lua`: `preset = "helix"` (column at the bottom right; `classic` and `modern` commented); groups
  `<space>b` buffers, `<space>s` search, `<space>u` ui, `h` comment (kept for now). The `c`, `g`, `t` groups
  come with their steps. The 17 `Ctrl-w` keys turned off in step 4 are `hidden = true`: which-key's
  built-in window preset would otherwise still list them.
- `<space>?` (`mappings.lua`): which-key popup with the current buffer's keys only
  (`show { global = false }`); `<space>sk` stays the full keymaps picker.

Fixes the `<space>` bug seen after step 6: without which-key, `<space>` waited `timeoutlen` (400 ms),
then ran Neovim's built-in `<space>` (move right), and `<space>E` typed slowly became "right" + `E`.
which-key's popup waits as long as it's open. `vim.g.mapleader` doesn't turn off the built-in `<space>`:
it only says what `<leader>` means when a mapping is defined. No `<space>` → `<Nop>` line (like LazyVim / NvChad).

`:checkhealth which-key`: no issues, no overlapping or duplicate keymaps.

To check in a real window: the `Ctrl-w` popup (no turned-off keys), what shows after `h` (operator).

Changes made by hand after the steps:

- `options.lua`: `listchars` commented out → Neovim's default (`tab:> ,trail:-,nbsp:+`, no `↵`).
- Borders: kept as they are. `winborder = "single"` only affects Neovim's own popups (hover, diagnostics);
  which-key (`win = { border = … }`) and snacks set their own. snacks falls back to `"rounded"` when
  `winborder` is `"none"`, and its picker layouts have fixed borders: changing them means a custom layout.

## Step 8: Treesitter + textobjects (2026-11-17)

Files:

- `lua/plugins/init.lua`: `nvim-treesitter/nvim-treesitter` and `nvim-treesitter/nvim-treesitter-textobjects`, both
  `branch = "main"`, `lazy = false` (the main branch doesn't lazy-load). nvim-treesitter has `build = ":TSUpdate"` and
  installs the list at startup; textobjects has `move = { set_jumps = true }`.
- `lua/configs/treesitter.lua`: the parser list (47 active, 29 commented), copied from the old config. Missing parsers
  are installed in the background at startup (`require("nvim-treesitter").install`), so `:TSInstallAll` is gone:
  uncomment a name and restart. The 7 parsers Neovim ships are in the list too (nvim-treesitter's queries expect its versions).
- `lua/autocmds.lua`: on `FileType`, `pcall(vim.treesitter.start)` (highlighting for every file type with a parser),
  then Treesitter indent (`indentexpr`, like Helix) only if the language has an `indents` query.
- `lua/mappings.lua`: the jumps below.

Keys (Normal, Visual, Operator-pending):

| Keys | Does | Replaces Neovim's |
|---|---|---|
| `]f` / `[f` | next / previous function | — |
| `]a` / `[a` | next / previous argument | argument list (`:next` / `:previous`) |
| `]t` / `[t` | next / previous class / type | tag stack |
| `]h` / `[h` | next / previous comment (`h` is the comment key) | — |

Decided:

- `]c`/`[c` = "change" everywhere: Neovim's diff-mode jump stays; gitsigns adds git hunks outside diff mode in
  step 13 (so no `]g`). Differs from Helix (`]c` comment, `]g` change).
- No `]T` (test): no language has a `@test` query in nvim-treesitter-textobjects.
- No `<space>uT` toggle, no Treesitter folding.

Tested: 51 parsers installed (47 + dependencies such as `php_only`, `html_tags`, `ecma`, `jsx`); Rust and Lua get
Treesitter highlighting and indent, a `.txt` file gets neither; jumps land on the right lines, `Ctrl-o` comes back;
`:checkhealth nvim-treesitter` without warnings.

Gotchas:

- The first install run was cut off when headless Neovim quit: `jsdoc` and `regex` had to be installed again.
  The startup install catches up on its own in a normal session.
- The `main` branch needs the `tree-sitter` CLI (0.26.11 here) and a C compiler.

Fix to step 3: the trim-on-save autocommand now skips buffers that can't be edited (`modifiable` off).
Saving `:checkhealth` output with `:w` gave `E21: Cannot make changes, 'modifiable' is off`.

Changed by hand: `configs/snacks.lua` indent has `animate = { enabled = false }` (no animation on the scope guide).
The global `vim.g.snacks_animate = false` would also turn off the dim animation; not used.

## Step 9: Mason (2026-11-17)

- `lua/plugins/init.lua`: `mason-org/mason.nvim` (`lazy = false`: its `bin` folder must be in Neovim's PATH before
  the LSP servers start) and `WhoIsSethDaniel/mason-tool-installer.nvim` (`lazy = false`: installs at startup).
- `lua/configs/mason.lua`: `lua-language-server`, `rust-analyzer`, `stylua` (Mason names).

How it works:

- Mason mostly downloads ready-made programs (no compiling, no sudo: everything goes in `~/.local/share/nvim/mason`).
  Some packages go through npm / pip / cargo / go instead, and need that tool.
- Mason puts `~/.local/share/nvim/mason/bin` first in **Neovim's** PATH only (LSP servers, formatters, `:!`,
  `:terminal`). The shell's PATH doesn't change.
- Mason installs; the LSP setup (step 10) says how to start a server and runs the first copy found in PATH.

Decided: rust-analyzer comes from Mason, so Neovim has its own copy even if rustup's (used by Helix) is removed.
Inside Neovim, Mason's copy wins (`0.3.3121-standalone`); Helix and the shell keep rustup's (`1.99.1`).
clippy and rustfmt still come from rustup.

Tested: the three packages installed; `exepath("rust-analyzer")` is Mason's; startup without messages.
Mason window keys (`i`, `u`, `X`, `Enter`, `g?`) have no hjkl: nothing to change. No key for `:Mason`.

## Step 10: LSP + lazydev (2026-11-17)

Files:

- `lua/plugins/init.lua`: `neovim/nvim-lspconfig` (`lazy = false`: its `lsp/*.lua` server descriptions must be in the
  runtimepath before the first file opens); `folke/lazydev.nvim` (`ft = "lua"`), with two library entries for
  what's used without `require`: `vim.uv` (luv types) and the `Snacks` global.
- `lua/configs/lspconfig.lua`: diagnostics like Helix (message at the end of other lines, full message under the
  cursor line, errors first), sign icons; `rust_analyzer` with `check.command = "clippy"`; `vim.lsp.enable` for
  `lua_ls` and `rust_analyzer`. No hand-written lua_ls library list (lazydev does it). The old `cssls` / `html` are
  left for "Later".
- `lua/configs/whichkey.lua`: `<space>c` group "code".

Keys (`lua/mappings.lua`):

| Keys | Does |
|---|---|
| `gd` `gD` `gr` `gi` `gy` | definition, declaration, references, implementation, type definition (snacks picker) |
| `k` | hover (since step 4) |
| `<space>cs` / `cS` | symbols in file / project |
| `<space>cc` / `cC` | incoming / outgoing calls |
| `<space>cd` / `cD` | diagnostics in file / project |
| `<space>ce` | line diagnostic (popup) |
| `<space>cr` `ca` `cl` | rename (snacks input), code actions, run code lens |
| `]d` `[d` `]D` `[D` | Neovim's: next / previous / last / first diagnostic (kept, same as Helix) |

Removed Neovim keys: `grn`, `gra` (Normal + Visual), `grr`, `gri`, `grt`, `grx`, `gO`, `Ctrl-w d`, `Ctrl-w Ctrl-d`.
`gi` was Neovim's "insert where Insert mode was left" (still reachable as `` `^i ``).

Decided: inlay hints off by default, `<space>uh` toggles them; the `<space>c` group is kept (Helix puts these
straight on `<space>`, but `<space>s` is search here).

Not needed here:

- blink capabilities: blink.cmp adds them to every server itself (step 11).
- Rename popup: `vim.lsp.buf.rename` asks through `vim.ui.input`, which snacks input replaces.

Tested: `lua_ls` attaches to the config with 0 diagnostics; a test file using `Snacks`, `vim.uv` and
`require("lazy")` only got "undefined global" for a made-up name; `rust_analyzer` attaches in a Cargo project and
reports rustc and clippy diagnostics; the removed keys are gone; startup without messages.

## Step 11: Completion (2026-11-17)

Files:

- `lua/plugins/init.lua`: `saghen/blink.cmp` (`version = "1.*"`: downloads the ready-made Rust fuzzy matcher;
  loads on `InsertEnter` / `CmdlineEnter`) with `rafamadriz/friendly-snippets`; `windwp/nvim-autopairs`
  (`InsertEnter`, `check_ts = true`: no pairing inside strings and comments).
- `lua/configs/blink.lua` (new): keys, documentation, ghost text, signature, sources, command line.

Keys:

| Where | Keys | Does |
|---|---|---|
| Insert menu | `Ctrl-n` / `Ctrl-p`, `↑` / `↓` | move (the arrows only while the menu is open; otherwise still off) |
| Insert menu | `Enter`, `Ctrl-e`, `Ctrl-Space` | accept, cancel, open |
| Insert menu | `Ctrl-u` / `Ctrl-d` | scroll the documentation (only while it's open; otherwise Insert mode's own `Ctrl-u` / `Ctrl-d`) |
| Snippets | `Tab` / `Shift-Tab` | next / previous field (a normal Tab when no snippet is active) |
| Insert | `Ctrl-k` | show / hide the signature popup |
| Command line | `Tab` / `Shift-Tab`, `Ctrl-n` / `Ctrl-p` | move; the selected item is written into the line, `Enter` runs it |
| Normal | `<space>ug` | toggle ghost text (snacks toggle on `vim.g.ghost_text`, read by blink) |

Removed: blink's `Ctrl-b` / `Ctrl-f` (docs scroll, moved to `Ctrl-u` / `Ctrl-d`) and its command-line `←` / `→`
(they keep moving the cursor); Neovim's `Ctrl-s` (signature, Insert + Select); digraphs (`Ctrl-k` → `<Nop>` in Insert
and the command line; blink's `Ctrl-k` falls back to it).

Settings: documentation beside the menu after 200 ms; signature popup opens by itself after `(`; ghost text on;
sources `lsp`, `path`, `snippets`, `buffer`, + `lazydev` for Lua (module names in `require`); command line: menu
shown while typing, no preselected item (so the first `Ctrl-n` picks the first item).

Snippets: friendly-snippets, expanded by Neovim's `vim.snippet` (no LuaSnip). Helix only expands snippets sent by
the language server; it has no snippet library.

Tested (Rust project): the menu and the documentation window open, `Enter` accepts (`String::ne(&self, other)`
with its fields), autopairs gives `foo()`; command line: menu shown, `Ctrl-n` → `checkhealth`;
`:checkhealth blink.cmp`: binary downloaded, one informational warning.

Gotchas:

- The fuzzy matcher is downloaded the first time blink loads (`blink.cmp  Downloading pre-built binary`).
- Headless test: the very first `:` (the one that loads blink) showed no menu; later ones did.

## Step 12: Format on save (2026-11-17)

- `lua/plugins/init.lua`: `stevearc/conform.nvim`, loaded on `BufWritePre` (first save), `:ConformInfo` or `<space>cf`.
- `lua/configs/conform.lua` (new): `lua` → `stylua` (Mason, reads `.stylua.toml`), `rust` → `rustfmt` (rustup, reads the
  edition from `Cargo.toml`). Format on save with `timeout_ms = 500`, `lsp_format = "fallback"` (no formatter in the
  list → the language server formats, if it can). `format_on_save` is a function that returns nothing when
  `vim.g.autoformat == false`.
- `lua/mappings.lua`: `<space>cf` format (Normal: file; Visual: selection, if the formatter supports it);
  `<space>uf` snacks toggle for format on save (`vim.g.autoformat`).

How it fits: Mason installs the formatter, conform knows how to run it (built-in list, `:h conform-formatters`),
`formatters_by_ft` is the choice. A server runs all session; a formatter runs once per save on the buffer's text.
The trim-on-save autocommand (step 3) stays, for files without a formatter.

Decided: no `rustfmt.toml` for single `.rs` files outside a Cargo project (rustfmt then uses the 2015 edition).

Tested: a squashed Rust file and a Lua file are formatted on `:w` (stylua used `.stylua.toml`); with the toggle off,
the file is saved as it is.

## Step 13: Git (2026-11-17)

- `lua/plugins/init.lua`: `lewis6991/gitsigns.nvim` (`BufReadPre` / `BufNewFile`), default options: signs on
  (drawn on the right of the numbers by snacks statuscolumn), line blame off.
- `lua/configs/whichkey.lua`: `<space>g` group "git".
- `lua/mappings.lua`: Git section + `<space>ub` toggle.

Keys:

| Keys | Does |
|---|---|
| `]c` / `[c` | next / previous change: git hunk, or Neovim's own jump in diff mode (gitsigns README recipe) |
| `ig` | hunk text object (`dig`, `yig`, `vig`) |
| `<space>gg` | lazygit (snacks, floating) |
| `<space>gs` `gl` `gf` `gL` `gb` `gd` `gS` | pickers: status, log of project / file / line, branches, diff (all hunks), stash |
| `<space>gp` | preview hunk |
| `<space>ga` / `gA` | stage hunk (Visual: selected lines; on a staged hunk: unstage) / stage file |
| `<space>gr` / `gR` | reset hunk (Visual: selected lines) / reset file |
| `<space>gB` | blame of the line (popup, full commit) |
| `<space>gD` | diff of the file, side by side (diff mode) |
| `<space>go` | open in browser (Normal, or Visual for a line range) |
| `<space>ub` | toggle line blame |

Decided: all 15 old keys kept (`gS` stash and `gL` line log are niche, but which-key lists them); `]g`/`[g` not used
(hunks are on `]c`); lazygit keeps its own keys (`j`/`k` and arrows both work), changing them means its own config:
another time.

Tested (temporary repo, 2 changed lines): 2 hunks; `]c` / `[c` go 5 → 20 → 5; `vig` selects the hunk; staging it
shows in `git diff --cached`; `<space>gD` opens 2 diff windows and `]c` there uses Neovim's diff jump.

## Step 14: flash (2026-11-17)

- `lua/plugins/init.lua`: `folke/flash.nvim`, `event = "VeryLazy"` (f / t must be ready right after startup).
- `lua/configs/flash.lua` (new): enhanced `f` `F` `t` `T` (matches highlighted, press `f` again for the next one);
  no labels in `/` `?` searches.
- `lua/mappings.lua`: Jump (flash) section.

| Keys | Modes | Does |
|---|---|---|
| `s` | Normal, Visual, Operator-pending | jump: type a few letters, then the label |
| `S` | Normal, Visual, Operator-pending | Treesitter select (labels on the code blocks around the cursor) |
| `r` | Operator-pending | remote: `yr` + label + motion = act over there, stay here |
| `R` | Visual, Operator-pending | Treesitter search: jump, then pick a code block there |
| `Ctrl-s` | while typing a `/` or `?` search | labels on the matches, for this search only (easy to forget!) |

Replaced Neovim keys: `s` (= `cl`), `S` (= `cc`), Visual `R` (= Visual `S`). Normal `r` (replace a character) stays.
Colours: the theme plugins style flash themselves (no more base46 line).

Decided: Visual `S` stays flash; nvim-surround's Visual key is chosen at step 16 (`gs`, Helix-like `ms`, or `S`).

Tested: `fa` then `f` goes to the next `a`; `s` + `targ` + label jumps to `target` on another line; the five keys mapped.

Gotcha: headless Neovim has no UI, so lazy.nvim's `VeryLazy` never fires there (flash, which-key): tests must load
them by hand (`require("lazy").load { plugins = { "flash.nvim" } }`).

## Step 15: todo-comments (2026-11-17)

- `lua/plugins/init.lua`: `folke/todo-comments.nvim`, `event = "VeryLazy"`: it registers its snacks picker source
  when it starts, so it must load before `<space>t` can be pressed (with `BufReadPost`, `<space>ta` from the dashboard
  would fail: unknown source). Files opened before and after it loads are highlighted.
- `lua/configs/todo.lua`: the old Helix keyword groups (`merge_keywords = false`): TODO, NOTE, WARN, FIX, HINT + alts.
- `lua/mappings.lua`: `<space>ta` all, `tt` TODO, `ti` NOTE / INFO, `tw` WARN / HACK, `te` FIX / BUG, `th` HINT / MOCK.
  No `]t` / `[t` (class / type since step 8).
- `lua/configs/whichkey.lua`: `<space>t` group "todo".

Decided: no plenary.nvim (a helper library for plugin authors). The pickers use snacks' grep (`rg`); only
todo-comments' own `:TodoQuickFix`, `:TodoLocList`, `:TodoTelescope` need plenary, and they now fail.
Colours: the groups link to the diagnostic colours, so they follow the theme (no base46 line).

Tested: a Lua file with TODO / FIX / BUG / NOTE and a "todo" without colon: highlighted; `<space>ta` finds 4,
the FIX group finds 2 (FIX + BUG).

## Where we are (2026-11-17, after step 15)

- Done: steps 0–15 (ticked in `BUILD-PLAN.md`).
- To test in a real window (step 7): `<space>` popup (no cursor move, `<space>E` typed slowly), `Ctrl-w`
  popup (no turned-off keys), what shows after `h`, toggle states under `<space>u`.
- To test in a real window (step 8): highlighting in a few languages, indent on Enter / `o`, the `]` jumps.
- To test in a real window (step 10): `gd` / `gr` pickers, `<space>cr` rename popup, diagnostics display, sign icons.
- To test in a real window (step 11): the menu and its docs, `Enter`, a snippet with `Tab`, the signature popup,
  `<space>ug`, the menu on the very first `:` after startup.
- To test in a real window (step 13): `<space>gg` lazygit, sign colours, `<space>ub`, `<space>go`.
- Next: step 16, text objects + surround (mini.ai, nvim-surround; surround's Visual key: `gs`, `ms` or `S`).
- Reminders: quotes are `i"` / `i'` / `` i` ``; `ii`/`ai` is snacks scope (indent). mini.ai (step 16) adds
  `iq` (any quote) and `ib` (any bracket).
