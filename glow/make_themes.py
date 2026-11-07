#!/usr/bin/env python3
"""Make one glow (glamour) style per alacritty theme.

Reads ~/.config/alacritty/themes/<name>.toml and writes
~/.config/glow/themes/<name>.json, so glow uses the same colors as the
terminal. theme_menu then points glow.yml to the chosen file.

Run it again after adding or changing an alacritty theme:
    python3 ~/.config/glow/make_themes.py
"""

import json
import tomllib
from pathlib import Path

ALACRITTY = Path.home() / ".config/alacritty/themes"
OUT = Path.home() / ".config/glow/themes"

# Same names as THEMES in ~/.config/niri/scripts/theme_menu
THEMES = [
    "catppuccin_frappe",
    "catppuccin_latte",
    "catppuccin_macchiato",
    "catppuccin_mocha",
    "gruvbox",
    "gruvbox_light",
]


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


def palette(name):
    colors = tomllib.loads((ALACRITTY / f"{name}.toml").read_text())["colors"]
    bg = colors["primary"]["background"]
    fg = colors["primary"]["foreground"]
    dark = is_dark(bg)
    # On a dark background the bright colors read better, on a light one
    # the normal (darker) ones.
    acc = colors["bright"] if dark else colors["normal"]
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


OUT.mkdir(parents=True, exist_ok=True)
for name in THEMES:
    (OUT / f"{name}.json").write_text(json.dumps(style(palette(name)), indent=2, ensure_ascii=False) + "\n")
    print("wrote", OUT / f"{name}.json")
