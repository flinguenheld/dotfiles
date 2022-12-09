#! /bin/lua

CURRENT_PATH = '~/.config/dotfiles/'
PATH_FILES = CURRENT_PATH .. "files/"

--------------------------------------------------
local files = {[".bashrc"]="~/",
               [".profile"]="~/",
               ["tox.ini"]="~/"}

local folders = {nvim='~/.config/nvim/',
                 i3='~/.config/i3/',
                 rofi='~/.config/rofi/',
                 terminator='~/.config/terminator/'}

--------------------------------------------------
-- Files
for key, value in pairs(files) do
    if arg[1] == 'install' then
        if value ~= "~/" then
            os.execute("rm -f" .. value .. key)
        end
        os.execute("mkdir " .. value)
        os.execute("cp -r " .. PATH_FILES .. key .. " " .. value .. key)
    else
        os.execute("rm " .. PATH_FILES .. key)
        os.execute("cp " .. value .. key .. " " .. PATH_FILES .. key)
    end
end

--------------------------------------------------
-- Folders
for key, value in pairs(folders) do
    if arg[1] == 'install' then
        os.execute("rm -rf " .. value .. key)
        os.execute("mkdir " .. value)
        os.execute("cp -r " .. CURRENT_PATH .. key .. "/* " .. value)
    else
        os.execute("rm -rf " .. CURRENT_PATH .. key)
        os.execute("cp -r " .. value .. " " .. CURRENT_PATH .. key)
    end
end
