-- NvChad UI settings: theme, highlights, dashboard, statusline, tabufline
-- Same structure as nvconfig.lua, which lists every available option:
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- ─────────────────────────────────────────────────────────────────────────────


---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
	integrations = { "flash", "snacks", "todo" }, -- theme colours for these plugins

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
