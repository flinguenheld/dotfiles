
require('colorbuddy').colorscheme('cobalt2')

vim.api.nvim_command('highlight HopNextKey      guifg=#FF0000       gui=bold')
vim.api.nvim_command('highlight HopNextKey1     guifg=#FFFF00       gui=bold')
vim.api.nvim_command('highlight HopNextKey2     guifg=#00FF00       gui=bold')
vim.api.nvim_command('highlight HopUnmatched    guifg=#9E9E9E       guibg=bg    guisp=#9E9E9E')

vim.api.nvim_command('highlight CursorLineNR    guifg=#9D79D6       gui=bold')





-- −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
-- −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
-- −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−



-- -- Default options
-- require('nightfox').setup({
--   options = {
--     -- Compiled file's destination location
--     -- compile_path = util.join_paths(vim.fn.stdpath("cache"), "nightfox"),
--     compile_file_suffix = "_compiled", -- Compiled file suffix
--     transparent = false,    -- Disable setting background
--     terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*)
--     dim_inactive = false,   -- Non focused panes set to alternative background
--     styles = {              -- Style to be applied to different syntax groups
--       comments = "italic",
--       functions = "italic,bold",
--       keywords = "NONE",
--       numbers = "NONE",
--       strings = "NONE",
--       types = "NONE",
--       variables = "NONE",
--     },
--     inverse = {             -- Inverse highlight for different types
--       match_paren = false,
--       visual = false,
--       search = false,
--     },
--     modules = {             -- List of various plugins and additional options
--       -- ...
--     },
--   }
-- })

-- -- setup must be called before loading
-- -- vim.cmd("colorscheme nightfox")



-- -- CHOIX −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
-- local nb = 0

-- function up()
--     nb =  nb + 1
--     if nb > 6 then
--         nb = 0
--     end 
--     updateScheme()
-- end

-- function down()
--     nb =  nb - 1
--     if nb < 0 then
--         nb = 6
--     end 
--      updateScheme()
-- end

-- vim.api.nvim_set_keymap('n', '<leader>à',  '<cmd>lua up()<CR>', {})
-- vim.api.nvim_set_keymap('n', '<leader>À',  '<cmd>lua down()<CR>', {})

-- function updateScheme()

--     local hop
--     local hopOne
--     local hopTwo

--     -- −−−−−−−−−−−−−−−−−−−

--     -- −−−−−−−−−−−−−−−−−−−
--     if nb == 0 then

--         vim.cmd("colorscheme nightfox")

--         vim.api.nvim_command('highlight HopNextKey      guifg=#F68541       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey1     guifg=#41F685       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey2     guifg=#41F685')
--         vim.api.nvim_command('highlight HopUnmatched    guifg=#353D59       guibg=bg    guisp=#363D59')

--         vim.api.nvim_command('highlight CursorLineNR    guifg=#9D79D6       gui=bold')

--     elseif nb == 1 then

--         vim.cmd("colorscheme nordfox")

--         vim.api.nvim_command('highlight HopNextKey      guifg=#FA3F39       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey1     guifg=#39FA3F       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey2     guifg=#39FA3F')
--         vim.api.nvim_command('highlight HopUnmatched    guifg=#495365       guibg=bg    guisp=#495365')

--         vim.api.nvim_command('highlight CursorLineNR    guifg=#C895BF       gui=bold')

--     elseif nb == 2 then

--         vim.cmd("colorscheme duskfox")

--         vim.api.nvim_command('highlight HopNextKey      guifg=#D00688       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey1     guifg=#88D006       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey2     guifg=#88D006')
--         vim.api.nvim_command('highlight HopUnmatched    guifg=#4F4B63       guibg=bg    guisp=#4F4B63')

--         vim.api.nvim_command('highlight CursorLineNR    guifg=#CCB1ED       gui=bold')

--     elseif nb == 3 then

--         vim.cmd("colorscheme dayfox")

--         vim.api.nvim_command('highlight HopNextKey      guifg=#E53730       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey1     guifg=#3730E5       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey2     guifg=#3730E5')
--         vim.api.nvim_command('highlight HopUnmatched    guifg=#BBBCC3       guibg=bg    guisp=#BBBCC3')

--         vim.api.nvim_command('highlight CursorLineNR    guifg=#6080B0       gui=bold')

--     elseif nb == 4 then

--         vim.cmd("colorscheme dawnfox")

--         vim.api.nvim_command('highlight HopNextKey      guifg=#EF4D46       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey1     guifg=#A146EF       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey2     guifg=#A146EF')
--         vim.api.nvim_command('highlight HopUnmatched    guifg=#BBBCC3       guibg=bg    guisp=#BBBCC3')

--         vim.api.nvim_command('highlight CursorLineNR    guifg=#286983       gui=bold')

--     elseif nb == 5 then

--         -- require('lualine').setup {
--         --   options = { theme  = 'ayu_mirage' },
--         -- }

--         vim.o.background = 'dark'
--         vim.cmd("colorscheme melange")

--         vim.api.nvim_command('highlight HopNextKey      guifg=#FF7926       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey1     guifg=#26ACFF       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey2     guifg=#26ACFF')
--         vim.api.nvim_command('highlight HopUnmatched    guifg=#443D37       guibg=bg    guisp=#443D37')

--         vim.api.nvim_command('highlight CursorLineNR    guifg=#CC7F2B    gui=bold')

--     else

--         -- require('lualine').setup {
--         --   options = { theme  = 'ayu_light' },
--         -- }

--         vim.o.background = 'light'
--         vim.cmd("colorscheme melange")

--         vim.api.nvim_command('highlight HopNextKey      guifg=#5DC633       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey1     guifg=#9D33C6       gui=bold')
--         vim.api.nvim_command('highlight HopNextKey2     guifg=#9D33C6')
--         vim.api.nvim_command('highlight HopUnmatched    guifg=#BBBCC3       guibg=bg    guisp=#BBBCC3')

--         vim.api.nvim_command('highlight CursorLineNR    guifg=#CC7F2B    gui=bold')

--     end 

--     -- −−−−−−−−−−−−−−−−−−−


--     -- vim.api.nvim_command('highlight HopNextKey      guifg=hop       gui=bold')
--     -- vim.api.nvim_command('highlight HopNextKey1     guifg=hopOne    gui=bold')
--     -- vim.api.nvim_command('highlight HopNextKey2     guifg=hopTwo')
--    -- vim.api.nvim_command('highlight HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242')
-- end

-- updateScheme()
