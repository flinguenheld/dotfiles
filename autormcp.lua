#! /bin/lua

CURRENT_PATH = '~/.config/dotfiles/'
PATH_FILES = CURRENT_PATH .. "confTerminal/"

--------------------------------------------------
local files = {[".bashrc"]="~/",
               [".profile"]="~/"}

local folders = {nvim='~/.config/nvim/',
                 i3='~/.config/i3/',
                 rofi='~/.config/rofi',
                 terminator='~/.config/terminator'}

--------------------------------------------------
-- Files
for key, value in pairs(files) do
    os.execute("rm " .. PATH_FILES .. key)
    os.execute("cp " .. value .. key .. " " .. PATH_FILES .. key)
end

--------------------------------------------------
-- Folders
for key, value in pairs(folders) do
    os.execute("rm -rf " .. CURRENT_PATH .. key)
    os.execute("cp -r " .. value .. " " .. CURRENT_PATH .. key)
end
