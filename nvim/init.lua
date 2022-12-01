-- Recommended by nvim-tree :
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Pouet
require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- TreeSitter
    use 'nvim-treesitter/nvim-treesitter'

    -- Lsp
    use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
    use 'williamboman/mason.nvim' -- New LspInstaller
    use 'williamboman/mason-lspconfig.nvim'

    -- Linter
    use 'jose-elias-alvarez/null-ls.nvim'

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-nvim-lsp-document-symbol' -- Doesn't work ;(

    -- Debug
    use 'folke/trouble.nvim'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'mfussenegger/nvim-dap-python'
    use 'theHamsta/nvim-dap-virtual-text'

    -- For luasnip users.
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'onsails/lspkind-nvim'

    use "rafamadriz/friendly-snippets"

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Marks
    use 'chentoast/marks.nvim'

    -- Tree
    use 'kyazdani42/nvim-tree.lua'

    -- Yank
    -- use  "tversteeg/registers.nvim"
    use {
        "tversteeg/registers.nvim",
        config = function()
            require("registers").setup()
        end,
    }
    -- Others
    use 'numToStr/Comment.nvim' -- gcc gbc

    use 'Pocco81/auto-save.nvim'
    use 'iamcco/markdown-preview.nvim' -- :call mkdp#util#install()
    use 'phaazon/hop.nvim'

    use "lukas-reineke/indent-blankline.nvim" -- Affiche l'indentation
    use 'RRethy/vim-illuminate' -- Illumine le mot (A-n pour aller au suivant)

    use 'machakann/vim-sandwich'
    use 'windwp/nvim-autopairs'

    -- Theme and starter
    use 'kyazdani42/nvim-web-devicons' -- Need nerd font like hack
    use 'ryanoasis/vim-devicons' -- Nécessaire ???
    use 'goolord/alpha-nvim'
    use 'nvim-lualine/lualine.nvim'
    use { 'lalitmee/cobalt2.nvim', requires = 'tjdevries/colorbuddy.nvim' }

    use 'norcalli/nvim-colorizer.lua'

    --
    use '/home/flo/plugins/luacomment.nvim'
    use '/home/flo/plugins/potpourri.nvim'

end
)

-- Leader --
vim.g.mapleader = ' '
vim.g.timeoulen = 3000

vim.o.termguicolors = true

-- Cool floating window popup menu for completion on command line
vim.opt.pumblend = 17
vim.opt.wildmode = "longest:full"
vim.opt.wildoptions = "pum"

vim.opt.completeopt = { "menu", "menuone", "noselect" } -- À confirmer
vim.opt.shortmess:append "c"

-- Ignore compiled files
vim.opt.wildignore = "__pycache__"
vim.opt.wildignore = vim.opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

-- Others
vim.opt.joinspaces = false -- no double spaces with join
-- vim.opt.mouse = "nv"                 -- Mouse active in normal & visual
vim.opt.cursorline = true
vim.opt.history = 100

-- Tabs
vim.opt.cindent = true
-- vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Numbers
vim.wo.relativenumber = true
vim.wo.number = true

-- Window
vim.opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
vim.opt.splitright = true -- Prefer windows splitting to the right
vim.opt.splitbelow = true -- Prefer windows splitting to the bottom
vim.opt.showmode = false -- Textes Insert/Visual en doublon avec powerline
vim.opt.equalalways = true -- I don't like my windows changing all the time

-- Pep8
vim.wo.colorcolumn = '115'

-- Text behaviour
vim.cmd [[filetype plugin on]]
vim.cmd [[autocmd FileType * setlocal formatoptions=cqrnj]]
--  - "a" -- Auto formatting is BAD.
--  - "t" -- Don't auto format my code. I got linters for that.
--  + "c" -- In general, I like it when comments respect textwidth
--  + "q" -- Allow formatting comments w/ gq
--  - "o" -- O and o, don't continue comments
--  + "r" -- But do continue when pressing enter.
--  + "n" -- Indent past the formatlistpat, not underneath it.
--  + "j" -- Auto-remove comments if possible.
--  + "j" -- Auto-remove comments if possible.
--  - "2" -- I'm not in gradeschool anymore

-- Highlight yank
vim.api.nvim_exec(
    [[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=249 }
    augroup END
    ]],
    false
)


-- require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_snipmate").lazy_load()
-- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/luasnip.lua"})


require('TreeSitter')
require('Telescope')
require('Trouble')
require('Dap')

require('AlphaStartup')
require('AutoSave')
require('IlluminateCursor')

require('Mason')
require('LspCmp')
require('LuaSnip')
require('Comments')
require('AutoPair')

require('IndentBlankLine')
require('Marks')

require('NvimTree')
require('LuaLine')
require('Hop')
require('ColorScheme')

require('Keybindings')


-- --------------------------
require 'colorizer'.setup()


--------------------------------------------------
-- Thanks Tj
--------------------------------------------------
P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end



-- -- TEST -------------------------------------------------------------------------------------------------------
-- local function blah()
-- 	print "Hello world !\n"
-- end
-- -- TEST -------------------------------------------------------------------------------------------------------
