return {
  "s1n7ax/nvim-window-picker",
  config = function()
    require("window-picker").setup({ selection_chars = "TSRNUEIAPDLFCGHM" })
  end,
}
