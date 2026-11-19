## Neovim config

Built from scratch (Neovim 0.12, lazy.nvim), with ideas taken from **LazyVim** (snacks, plugin choices, keys)
and **NvChad** (layout, habits), and Helix-style keys where possible.

## Files

```
~/.config/nvim/
├── init.lua                    leader key, lazy.nvim bootstrap, loads the files below
├── lazy-lock.json              plugin versions (written by lazy.nvim)
├── .stylua.toml                Lua formatting
└── lua/
    ├── options.lua             editor options
    ├── autocmds.lua            code run on events
    ├── mappings.lua            all keys, one section per topic
    ├── plugins/
    │   ├── init.lua            plugin list (one entry per plugin, alphabetical)
    │   └── colorscheme.lua     themes + theme_menu signal
    └── configs/                each plugin's settings
        ├── blink.lua           completion
        ├── bufferline.lua      buffer bar
        ├── conform.lua         format on save
        ├── flash.lua           jumps
        ├── highlightcolors.lua colour squares
        ├── lazy.lua            plugin manager
        ├── lspconfig.lua       LSP servers, diagnostics
        ├── lualine.lua         statusline
        ├── mason.lua           tools to install
        ├── miniai.lua          text objects
        ├── snacks.lua          pickers, explorer, dashboard…
        ├── todo.lua            TODO comments
        ├── treesitter.lua      parsers
        ├── whichkey.lua        key hints, group names
        └── yanky.lua           yank history
```

### Plugins

| Plugin | For |
|---|---|
| lazy.nvim | plugin manager |
| snacks.nvim | pickers, explorer, dashboard, notifications, indent guides, scope, words, lazygit, toggles |
| which-key.nvim | key hints popup |
| lualine.nvim | statusline |
| bufferline.nvim | buffer bar (2+ buffers, alphabetical) |
| mini.icons | icons (also stands in for nvim-web-devicons) |
| catppuccin, gruvbox, everforest, ayu | themes |
| flash.nvim | jumps with labels, enhanced `f` / `t` |
| nvim-surround | surround (`h…` keys) |
| mini.ai | `a` / `i` text objects (function, argument, quotes…) |
| nvim-autopairs | auto brackets |
| yanky.nvim | yank history |
| grug-far.nvim | search & replace in the project |
| todo-comments.nvim | TODO / FIX… highlights and pickers |
| nvim-highlight-colors | colour squares next to colour codes |
| gitsigns.nvim | git signs, hunks, blame |
| nvim-treesitter (+ textobjects) | parsers, highlighting, `]f` `]a` `]t` `]k` jumps |
| nvim-lspconfig | LSP server settings |
| lazydev.nvim | lua_ls knows the config and plugins |
| mason.nvim (+ tool-installer) | installs LSP servers, formatters, tree-sitter |
| blink.cmp (+ friendly-snippets) | completion, snippets |
| conform.nvim | format on save |

### Keys

Leader is `<space>`. Full list: **`<space>??`** (which-key, this buffer) and **`<space>?k`** (all keymaps).

- **Moves:** arrows only (`hjkl` off). `Ctrl-←↓↑→` go to a window, `Ctrl-w Ctrl-←↓↑→` move it.
  `Alt-←/→` previous / next buffer. `s` flash jump, `S` flash Treesitter select.
- **Jumps:** `]f` function, `]a` argument, `]t` class / type, `]k` comment, `]c` git change, `]r` reference,
  `]d` diagnostic (and `[` for previous).
- **Editing:** `k` comment (`kk` line). `hh` surround add, `hH` around the line, `hS` on own lines, `hd` delete,
  `hr` replace. `U` redo. `p` / `P` paste, then `Ctrl-p` / `Ctrl-n` for another yank. `<space>y` yank to the
  system clipboard. `Esc` clears the search highlight.
- **LSP:** `gd` definition, `gD` declaration, `gr` references, `gi` implementation, `gy` type.
  `<space>k` hover, `K` help / man page.
- **`<space>` groups:**
  - `?` help: `??` keys, `k` keymaps, `c` commands, `h` help pages, `a` autocmds, `i` inspect,
    `n` notifications, `l` Lazy, `m` Mason, `C` checkhealth
  - `b` buffers, `c` code, `g` git, `s` search, `t` todo, `u` toggles (on / off)
  - `e` / `E` explorer, `r` search & replace, `y` clipboard yank
- **Removed from Neovim** (replaced above): `gc` / `gcc`, `gr*` and `gO`, `Ctrl-r`, `[b` / `]b`, `Ctrl-s` in
  Insert, digraphs `Ctrl-k`, the `Ctrl-w` hjkl keys.

### Options

Only what differs from Neovim's defaults (`options.lua`):

- Numbers: `number` + `relativenumber`, `cursorline` (line + number), `signcolumn = "yes"`, `colorcolumn = "80"`.
- Indent: spaces, width 2 (`expandtab`, `shiftwidth`, `softtabstop`, `tabstop`).
- Search: `ignorecase` + `smartcase`, `inccommand = "split"`.
- Splits: `splitbelow`, `splitright`, `splitkeep = "screen"`.
- Display: `wrap = false`, `scrolloff = 10`, `list`, `winborder = "single"`, `laststatus = 3`, `showmode = false`,
  `showcmdloc = "statusline"`, `shortmess` + `S` and `q` (lualine shows them).
- Other: `clipboard = ""` (like Helix), `mouse = "a"`, `undofile`, `timeoutlen = 400`, `updatetime = 250`;
  node / perl / python / ruby providers off.

### Autocmds

`autocmds.lua`:

- **Trim on save:** spaces at line ends and empty lines at the end of the file.
- **Comment continuation:** off (Enter, `o`, `O`).
- **Treesitter:** highlighting + indent for each file type with a parser.
- **Search count:** `[2/5]` at the end of the line when the cursor is on a match.
- **Resize splits:** splits made equal again when the terminal is resized and when the explorer opens.

`plugins/colorscheme.lua`: theme applied at startup and on `SIGUSR1` (see Themes).

### Themes

- `~/.config/theme/theme_menu` writes `theme="…"` to `~/.config/theme/palette.toml` and runs `pkill -USR1 nvim`:
  every open Neovim switches theme at once.
- Names in `colorscheme.lua`: catppuccin (frappe, latte, macchiato, mocha), gruvbox (dark, light),
  everforest (dark, light), ayu (light, mirage). Default: `catppuccin_frappe`.
- Unknown name or missing file: warning + default theme.
- `<space>ut`: try a theme for this session only (the file stays the reference).
- lualine and bufferline follow the theme by themselves.

### Good to know

- **`vim.keymap.del` errors at startup** if the key doesn't exist. If a new Neovim version renames or drops one
  of its default keys, delete the matching `del(...)` line in `mappings.lua`.
- which-key doesn't list text objects after `k`: press `y` or `d` and wait to see them.
- Testing headless: `VeryLazy` and `UIEnter` don't fire, so load plugins by hand (`Lazy! load <plugin>`).

### To do

- Languages (from Helix): Python (ty, ruff), Haskell (hls), Markdown (harper-ls, dprint, render-markdown),
  TOML (taplo, crates-lsp, SchemaStore), JSON / CSS (biome), HTML (+ nvim-ts-autotag), KDL,
  Bash (shfmt, no format on save), per-language rulers.
- Plugins: trouble.nvim, crates.nvim, nvim-dap, persistence.nvim, guess-indent.nvim.
- Optional: mini.align (Helix `&`), treesj (split / join), mini.move, a terminal toggle (`Snacks.terminal`),
  snacks scratch, dashboard customisation.
