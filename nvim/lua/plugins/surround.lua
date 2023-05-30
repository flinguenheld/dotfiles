return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        insert = "<C-g>l",
        insert_line = "<C-g>L",
        normal = "la",
        normal_cur = "laa",
        normal_line = "lL",
        normal_cur_line = "ll",
        visual = "la",
        visual_line = "ll",
        delete = "ld",
        change = "lr",
      },
    })
  end,
}
