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
