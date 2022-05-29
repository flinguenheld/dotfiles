-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-F>'] = cmp.mapping.scroll_docs(4),
    ['<C-c>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})


-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

  -- Setup lspconfig.
  -- SEE ILLUMINATE TO ALLOW MOVES
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['pyright'].setup {
  --   capabilities = capabilities,
  -- }
  -- require('lspconfig')['pylsp'].setup {
  --   capabilities = capabilities,
  -- -- filetypes = {"python"},

  -- }

require'lspconfig'.pylsp.setup{

    capabilities = capabilities,
settings = {
            pylsp = {
                plugins = {
                    configurationSources = { "flake8", "mypy", "pycodestyle" },
                    -- flake8 = { enabled = false},
                    mypy = { enabled = true },
                    pycodestyle= {enabled = true,
                                  maxLineLength=118,
                                  ignore={'E127'},
                                  -- ignore={'E302', 'E127', 'E501'},
                                 },
                    pyflakes = {enabled=true},
                },
            },
        },

}

  require('lspconfig')['emmet_ls'].setup {
    capabilities = capabilities,
    filetypes = { "html", "htmldjango", "css", "typescriptreact", "javascriptreact" },
  }
  require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities
  }

