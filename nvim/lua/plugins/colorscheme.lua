return {
  {
    "tokyonight.nvim",
    priority = 1000,
    opts = function()
      return {
        -- style = "moon",
        -- transparent = true,
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
        on_highlights = function(hl, c)
          -- hl.Substitute = { fg = c.orange, bold = true }

          -- hl.FlashBackdrop = { fg = c.comment }
          -- hl.FlashMatch = { fg = c.search }
          -- hl.FlashCurrent = { fg = c.incsearch }
          hl.FlashLabel = { bg = c.magenta2, fg = c.black, bold = true }
        end,
      }
    end,
  },
}
