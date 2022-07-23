-- TELESCOPE −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
require("telescope").setup {


defaults = { file_ignore_patterns = {"env", "__pycache__"} },
  extensions = {

    fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },

    file_browser = {
          -- theme = "ivy",

          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
    },
  },
}

require('telescope').load_extension('fzy_native')
require("telescope").load_extension "file_browser"



-- Old attempts
-- function FindFiles_3()
--     require('telescope.builtin').find_files{
--         cwd =  vim.fn.expand('%:p:h:h:h:h'),
--         prompt_title = string.format("Recherche (-1): %s/", vim.fn.expand('%:p:h:h:h:h')),
--     }
-- end

-- function LiveGrep_Home()

--     require('telescope.builtin').live_grep{
--         search_dirs = {os.getenv("HOME")},
--         prompt_title = os.getenv("HOME"),
--     }
-- end
