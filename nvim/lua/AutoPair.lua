-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    -- java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })


-- vim.b['surround_{char2nr("v")}'] = "{{ \r }}"
-- let b:surround_{char2nr("{")} = "{{ \r }}"
-- let b:surround_{char2nr("%")} = "{% \r %}"
-- let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
-- let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
-- let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
-- let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
-- let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

