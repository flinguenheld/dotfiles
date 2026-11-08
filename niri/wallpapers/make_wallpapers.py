#!/usr/bin/env python3
"""Make the theme wallpapers: the palette as a row of dots in the middle.

    ┌──────────────────────────────────────────────┐
    │                (soft gradient)                │
    │      ●   ●   ●   ●   ●   ●   ●   ●            │
    │    #f38 #fab #f9e #a6e #94e #89b #cba #f5c    │
    │              catppuccin · mocha               │
    └──────────────────────────────────────────────┘

Usage:
    python3 make_wallpapers.py              # all themes
    python3 make_wallpapers.py gruvbox      # only some themes

The files are written next to this script, named like THEMES in
~/.config/niri/scripts/theme/theme_menu (gruvbox.jpg, ayu_light.jpg…).
Needs ImageMagick 7 (`magick`) and the JetBrains Mono Nerd Font.
"""

import subprocess
import sys
from pathlib import Path

OUT = Path(__file__).resolve().parent
W, H = 3840, 2160
R, GAP = 95, 70  # dot radius, space between dots
FONT = "JetBrainsMono-NF-Bold"
FONT_LIGHT = "JetBrainsMono-NF-Regular"

# bg: same as the WezTerm scheme. dots: the family's official palette,
# roughly red, orange, yellow, green, cyan, blue, purple, pink/grey.
# The gradient ends on a light tint of the last-but-one dot.
THEMES = {
    "catppuccin_frappe": dict(
        title="catppuccin · frappé", dark=True, bg="#303446", fg="#c6d0f5",
        dots=["#e78284", "#ef9f76", "#e5c890", "#a6d189", "#81c8be", "#8caaee", "#ca9ee6", "#f4b8e4"]),
    "catppuccin_latte": dict(
        title="catppuccin · latte", dark=False, bg="#eff1f5", fg="#4c4f69",
        dots=["#d20f39", "#fe640b", "#df8e1d", "#40a02b", "#179299", "#1e66f5", "#8839ef", "#ea76cb"]),
    "catppuccin_macchiato": dict(
        title="catppuccin · macchiato", dark=True, bg="#24273a", fg="#cad3f5",
        dots=["#ed8796", "#f5a97f", "#eed49f", "#a6da95", "#8bd5ca", "#8aadf4", "#c6a0f6", "#f5bde6"]),
    "catppuccin_mocha": dict(
        title="catppuccin · mocha", dark=True, bg="#1e1e2e", fg="#cdd6f4",
        dots=["#f38ba8", "#fab387", "#f9e2af", "#a6e3a1", "#94e2d5", "#89b4fa", "#cba6f7", "#f5c2e7"]),
    "gruvbox": dict(
        title="gruvbox · dark", dark=True, bg="#282828", fg="#ebdbb2",
        dots=["#fb4934", "#fe8019", "#fabd2f", "#b8bb26", "#8ec07c", "#83a598", "#d3869b", "#a89984"]),
    "gruvbox_light": dict(
        title="gruvbox · light", dark=False, bg="#fbf1c7", fg="#3c3836",
        dots=["#9d0006", "#af3a03", "#b57614", "#79740e", "#427b58", "#076678", "#8f3f71", "#7c6f64"]),
    "ayu_mirage": dict(
        title="ayu · mirage", dark=True, bg="#1f2430", fg="#cbccc6",
        dots=["#f28779", "#ffcc66", "#ffd580", "#bae67e", "#95e6cb", "#73d0ff", "#d4bfff", "#cbccc6"]),
    "ayu_light": dict(
        title="ayu · light", dark=False, bg="#fafafa", fg="#5c6773",
        dots=["#ff3333", "#ff6a00", "#f29718", "#86b300", "#4dbf99", "#41a6d9", "#f07178", "#5c6773"]),
    "everforest_dark": dict(
        title="everforest · dark", dark=True, bg="#2d353b", fg="#d3c6aa",
        dots=["#e67e80", "#e69875", "#dbbc7f", "#a7c080", "#83c092", "#7fbbb3", "#d699b6", "#859289"]),
    "everforest_light": dict(
        title="everforest · light", dark=False, bg="#fdf6e3", fg="#5c6a72",
        dots=["#f85552", "#f57d26", "#dfa000", "#8da101", "#35a77c", "#3a94c5", "#df69ba", "#939f91"]),
}


def mix(a, b, t):
    """Color between a (t = 0) and b (t = 1)."""
    ca = [int(a[i : i + 2], 16) for i in (1, 3, 5)]
    cb = [int(b[i : i + 2], 16) for i in (1, 3, 5)]
    return "#" + "".join(f"{round(x + (y - x) * t):02x}" for x, y in zip(ca, cb))


def make(name, c):
    n = len(c["dots"])
    row = n * 2 * R + (n - 1) * GAP
    x0, cy = (W - row) // 2 + R, H // 2 - 60
    muted = mix(c["fg"], c["bg"], 0.45)
    end = mix(c["bg"], c["dots"][-2], 0.22 if c["dark"] else 0.16)

    dots, labels = [], []
    for i, col in enumerate(c["dots"]):
        x = x0 + i * (2 * R + GAP)
        dots += ["-fill", col, "-draw", f"circle {x},{cy} {x + R},{cy}"]
        # -annotate offsets are from the center (-gravity center)
        labels += ["-annotate", f"+{x - W // 2}+{cy + R + 70 - H // 2}", col]

    cmd = [
        "magick",
        # 1. background: soft diagonal gradient
        "-size", f"{W}x{H}", "-define", "gradient:angle=135",
        f"gradient:{c['bg']}-{end}",
        # 2. the dots on a transparent layer, plus their soft shadow
        "(", "-size", f"{W}x{H}", "xc:none", *dots,
        "(", "+clone", "-background", "black",
        "-shadow", f"{45 if c['dark'] else 22}x28+0+18", ")",
        "+swap", "-background", "none", "-layers", "merge", ")",
        "-layers", "flatten",
        # 3. hex codes under the dots
        "-gravity", "center", "-font", FONT_LIGHT, "-pointsize", "34",
        "-fill", muted, *labels,
        # 4. theme name
        "-font", FONT, "-pointsize", "64",
        "-fill", mix(c["fg"], c["bg"], 0.2),
        "-annotate", f"+0+{cy + R + 230 - H // 2}", c["title"],
        # A little noise hides the banding of a large gradient. Less on
        # light themes: near white it gets clipped and shows as grain.
        # The noise is also what makes a JPEG heavy (it can't be compressed):
        # 0.1 and quality 85 keep a 4K wallpaper around 300 KB.
        "-attenuate", "0.1" if c["dark"] else "0.06", "+noise", "Gaussian",
        "-quality", "85", str(OUT / f"{name}.jpg"),
    ]
    subprocess.run(cmd, check=True)
    print("wrote", OUT / f"{name}.jpg")


names = sys.argv[1:] or list(THEMES)
for name in names:
    if name not in THEMES:
        raise SystemExit(f"unknown theme {name!r}, known: {', '.join(THEMES)}")
    make(name, THEMES[name])
