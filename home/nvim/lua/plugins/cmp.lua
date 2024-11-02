return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    require("cmp").setup.cmdline({ "/", "?" }, {
      mapping = require("cmp").mapping.preset.cmdline(),
      sources = {
        {
          name = "buffer",
          option = { keyword_pattern = [[\k\+]] },
        },
      },
    })
  end,
}
