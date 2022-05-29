local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

-- Set header
dashboard.section.header.val = {


"                                              ",
"           #########                          ",
"      #########@@@@@@##                       ",
"       ######@@@@@@@@@@#                      ",
"     #######@@@@@@@@@@@@@#                    ",
"        ##@@@@@@@@@@@  @@@#                   ",
"     #####@@@@@@  @@@  @@@#                   ",
"        #@@@@@@@  @@@@@@@@#                   ",
"         #@@@@@@@@@@@@@@@@@########           ",
"          #@@@@@@@@@@@@@@@@@@@@@@#            ",
"           #@@@@@@@@@@@@@@@@@@@@#             ",
"            #@@@@@@@@@@@@@@@@@@#              ",
"            #@@@@@@@@@@@@@@@@#                ",
"             #@@@@@@@@@@@@@#                  ",
"             #@@@@@@@@@@@@@#                  ",
"              #@@@@@@@@@@@@@#                 ",
"              #@@@@@@@@@@@@@@#                ",
"              #@@@@@@@@@@@@@@@#               ",
"              #@@@@@@@@@@@@@@@@#              ",
"              #@@@@@@@@@@@@@@@@#              ",
"              #@@@@@@@@@@@@@@@@@#             ",
"             #@@@@@@@@@@@@@@@@@@@#            ",
"             #@@@@@@@@@@@@@@@@@@@@#           ",
"            #@@@@@@@@@@@@@@@@@@@@@@#          ",
"           #@@@@@@@@@@@@@@@@@@@@@@@@#         ",
"          #@@@@@@@#  @@@@@#    @@@@@@#        ",
"         #@@@@@#      @@@#        @@@@#       ",
"        #@@@#          @#           @@@#      ",
"       #@#                            @#      ",
"                                              ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "o", "  > Old files" ,           ":Telescope oldfiles<CR>"),
    dashboard.button( "e", "  > New file" ,            ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "  > Find file",            "<cmd>lua FindFiles_Current()<CR>"),
    dashboard.button( "ç", "  > Find file (home)",     "<cmd>lua FindFiles_Home()<CR>"),
    dashboard.button( "R", "  > Find folders",         "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({hidden=true})<CR>"),
    dashboard.button( "i", "  > Init",                 ":e $MYVIMRC<CR>"),
    dashboard.button( "q", "  > Quit NVIM",            ":qa<CR>"),
}



dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
