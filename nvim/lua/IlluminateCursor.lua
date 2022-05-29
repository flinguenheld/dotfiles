-- ILLUMINATE −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
require'lspconfig'.pyright.setup {
    on_attach = function(client)
        require 'illuminate'.on_attach(client)
    end,
}

require'lspconfig'.emmet_ls.setup {
    on_attach = function(client)
        require 'illuminate'.on_attach(client)
    end,
}

require'lspconfig'.sumneko_lua.setup {
    on_attach = function(client)
        require 'illuminate'.on_attach(client)
    end,
}

vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require "illuminate".next_reference{wrap=true}<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require "illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
