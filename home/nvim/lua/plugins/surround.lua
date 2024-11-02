return {

  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        insert = "<C-g>h",
        insert_line = "<C-g>h",

        normal = "h",
        normal_cur = "hh",
        normal_line = "ho", -- Usefull ?
        normal_cur_line = "hoh",
        delete = "hd",
        change = "hr",

        visual = "h",
        visual_line = "ho",
      },

      vim.cmd.highlight("default link NvimSurroundHighlight IncSearch"),
      move_cursor = false, -- Move the cursor to the beginning after surrounding
    })
  end,
}
