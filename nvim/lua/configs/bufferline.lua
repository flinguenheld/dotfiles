-- bufferline.nvim: the bar of open buffers at the top, shown only with 2+ buffers (like Helix bufferline = "multiple")
-- Keys in mappings.lua (Buffers section): Alt-← / Alt-→, <space>bb pick; colours follow the theme
-- See all options: https://github.com/akinsho/bufferline.nvim (:help bufferline-configuration)
-- ─────────────────────────────────────────────────────────────────────────────

-- ─────────────────────────────────────────────────────────────── SORTING ─────

-- Alphabetical by file name (upper / lower case mixed), then by full path when two files share a name
local function by_name(a, b)
  local name_a, name_b = a.name:lower(), b.name:lower()
  if name_a ~= name_b then return name_a < name_b end
  return a.path < b.path
end

-- ─────────────────────────────────────────────────────────────────────────────

return {
  options = {
    always_show_bufferline = false, -- hidden with a single buffer
    sort_by = by_name, -- tabs kept in alphabetical order (SORTING above)

    -- separator_style = "thin", -- the default: a thin line
    -- separator_style = "thick",
    separator_style = "slant",

    left_mouse_command = false,
    right_mouse_command = false,
    middle_mouse_command = false,

    show_buffer_close_icons = false,
    diagnostics = false,
    show_duplicate_prefix = true, -- two files with the same name: each tab also shows its folder

    -- When the snacks explorer is open on the left, the bar starts to the right of it
    offsets = {
      { filetype = "snacks_layout_box" },
    },
  },
}
