#!/usr/bin/env python3
"""Make one glow (glamour) style per WezTerm color scheme.

WezTerm's schemes are built into its binary, so there is no file to read.
This script asks WezTerm itself: it runs `wezterm show-keys` with a tiny
Lua config that writes the colors of each scheme to a JSON file.

    make_themes.py ─▶ dump.lua ─▶ wezterm ─▶ colors.json ─▶ themes/*.json

theme_menu then points glow.yml to the chosen file.

Run it again after adding a theme to THEMES:
    python3 ~/.config/glow/make_themes.py
"""

import json
import subprocess
import tempfile
from pathlib import Path

OUT = Path.home() / ".config/glow/themes"

# glow file name ─▶ WezTerm scheme name.
# Same pairs as THEMES / THEMES_WZ in ~/.config/niri/scripts/theme_menu
THEMES = {
    "catppuccin_frappe": "Catppuccin Frappe",
    "catppuccin_latte": "Catppuccin Latte",
    "catppuccin_macchiato": "Catppuccin Macchiato",
    "catppuccin_mocha": "Catppuccin Mocha",
    "gruvbox": "Gruvbox Dark (Gogh)",
    "gruvbox_light": "Gruvbox (Gogh)",
    "ayu_mirage": "Ayu Mirage",
    "ayu_light": "ayu_light",
    "modus_vivendi": "Modus-Vivendi",
    "modus_operandi": "Modus-Operandi",
}

# Order of WezTerm's `ansi` and `brights` lists
ANSI = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]

LUA = """
local wezterm = require 'wezterm'
local schemes = wezterm.color.get_builtin_schemes()
local out = {}
for _, name in ipairs(wezterm.serde.json_decode([==[%s]==])) do
  local s = schemes[name]
  if s then
    -- only these fields: the full table can't be encoded to JSON
    out[name] = { background = s.background, foreground = s.foreground,
                  ansi = s.ansi, brights = s.brights }
  end
end
local f = io.open([==[%s]==], 'w')
f:write(wezterm.serde.json_encode(out))
f:close()
return {}
"""


def wezterm_schemes(names):
    """Ask WezTerm for the colors of these built-in schemes."""
    with tempfile.TemporaryDirectory() as tmp:
        lua, out = Path(tmp) / "dump.lua", Path(tmp) / "colors.json"
        lua.write_text(LUA % (json.dumps(names), out))
        # show-keys only loads the config and prints the key table:
        # a quick way to run Lua inside WezTerm without opening a window
        subprocess.run(
            ["wezterm", "--config-file", str(lua), "show-keys"],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
            timeout=30, check=False,
        )
        text = out.read_text() if out.exists() else ""
    if not text:
        raise SystemExit("wezterm wrote no colors (Lua error?)")
    return json.loads(text)


def rgb(hex_color):
    h = hex_color.lstrip("#")
    return [int(h[i : i + 2], 16) for i in (0, 2, 4)]


def mix(a, b, t):
    """Color between a (t = 0) and b (t = 1)."""
    ca, cb = rgb(a), rgb(b)
    return "#" + "".join(f"{round(x + (y - x) * t):02x}" for x, y in zip(ca, cb))


def is_dark(hex_color):
    r, g, b = rgb(hex_color)
    return 0.299 * r + 0.587 * g + 0.114 * b < 128


def palette(scheme):
    bg, fg = scheme["background"], scheme["foreground"]
    dark = is_dark(bg)
    # On a dark background the bright colors read better, on a light one
    # the normal (darker) ones.
    acc = dict(zip(ANSI, scheme["brights"] if dark else scheme["ansi"]))
    return {
        "bg": bg,
        "fg": fg,
        "muted": mix(fg, bg, 0.45),
        "code_bg": mix(bg, fg, 0.08),
        **{k: acc[k] for k in ("red", "green", "yellow", "blue", "magenta", "cyan")},
    }


def style(p):
    c = lambda color, **kw: {"color": p[color], **kw}
    return {
        "document": {"block_prefix": "\n", "block_suffix": "\n", "color": p["fg"], "margin": 2},
        "block_quote": {"indent": 1, "indent_token": "│ ", "color": p["muted"], "italic": True},
        "paragraph": {},
        "list": {"level_indent": 2},
        "heading": {"block_suffix": "\n", "color": p["blue"], "bold": True},
        "h1": {"prefix": " ", "suffix": " ", "color": p["bg"], "background_color": p["magenta"], "bold": True},
        "h2": c("blue", prefix="## "),
        "h3": c("cyan", prefix="### "),
        "h4": c("green", prefix="#### "),
        "h5": c("yellow", prefix="##### "),
        "h6": c("muted", prefix="###### ", bold=False),
        "text": {},
        "strikethrough": {"crossed_out": True},
        "emph": c("yellow", italic=True),
        "strong": c("red", bold=True),
        "hr": c("muted", format="\n────────\n"),
        "item": {"block_prefix": "• "},
        "enumeration": {"block_prefix": ". "},
        "task": {"ticked": "[✓] ", "unticked": "[ ] "},
        "link": c("cyan", underline=True),
        "link_text": c("blue", bold=True),
        "image": c("magenta", underline=True),
        "image_text": c("muted", format="Image: {{.text}} →"),
        "code": {"prefix": " ", "suffix": " ", "color": p["red"], "background_color": p["code_bg"]},
        "code_block": {
            "color": p["fg"],
            "margin": 2,
            "chroma": {
                "text": c("fg"),
                "error": {"color": p["bg"], "background_color": p["red"]},
                "comment": c("muted", italic=True),
                "comment_preproc": c("yellow"),
                "keyword": c("magenta"),
                "keyword_reserved": c("magenta"),
                "keyword_namespace": c("red"),
                "keyword_type": c("yellow"),
                "operator": c("cyan"),
                "punctuation": c("fg"),
                "name": c("fg"),
                "name_builtin": c("red"),
                "name_tag": c("blue"),
                "name_attribute": c("yellow"),
                "name_class": c("yellow", bold=True),
                "name_constant": c("yellow"),
                "name_decorator": c("cyan"),
                "name_exception": c("red"),
                "name_function": c("blue"),
                "name_other": {},
                "literal": {},
                "literal_number": c("yellow"),
                "literal_date": {},
                "literal_string": c("green"),
                "literal_string_escape": c("cyan"),
                "generic_deleted": c("red"),
                "generic_emph": {"italic": True},
                "generic_inserted": c("green"),
                "generic_strong": {"bold": True},
                "generic_subheading": c("muted"),
                "background": {"background_color": p["code_bg"]},
            },
        },
        "table": {},
        "definition_list": {},
        "definition_term": {},
        "definition_description": {"block_prefix": "\n🠶 "},
        "html_block": {},
        "html_span": {},
    }


schemes = wezterm_schemes(list(THEMES.values()))
OUT.mkdir(parents=True, exist_ok=True)
for name, scheme_name in THEMES.items():
    if scheme_name not in schemes:
        print(f"skip {name}: no WezTerm scheme named {scheme_name!r}")
        continue
    path = OUT / f"{name}.json"
    path.write_text(json.dumps(style(palette(schemes[scheme_name])), indent=2, ensure_ascii=False) + "\n")
    print("wrote", path)
