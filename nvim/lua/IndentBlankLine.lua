-- INDENT BLANK LINE −−-−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
vim.opt.list = true
vim.opt.listchars:append("space: ")
vim.opt.listchars:append("eol:↴")
vim.opt.termguicolors = true


require("indent_blankline").setup {

    space_char_blankline = " ",
    show_current_context = true,
    -- show_current_context_start = true,
    -- show_end_of_line = true,
    use_treesitter = true,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
}
