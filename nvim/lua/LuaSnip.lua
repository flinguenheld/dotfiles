
local ls = require 'luasnip'



require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })




ls.config.set_config {

    history = true,
    updateevents = 'TextChanged, TextChangedI',
    enable_autosnippets = true,
}

vim.keymap.set({'i', 's'}, '<c-n>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true})


vim.keymap.set({'i', 's'}, '<c-p>', function()
    if ls.jumpable() then
        ls.jump(-1)
    end
end, {silent = true})


vim.keymap.set('i', '<c-l>', function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice<CR>")
vim.keymap.set('n', '<leader>s', '<cmd>source ~/.config/nvim/snippets/luasnip.lua<CR>')
