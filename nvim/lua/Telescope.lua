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


function FindFiles_Current()
    require('telescope.builtin').find_files{
        cwd =  vim.fn.expand('%:p:h'),
        prompt_title = string.format("Recherche (current): %s/", vim.fn.expand('%:p:h')),
        -- hidden = true,
    }
end
function FindFiles_1()
    require('telescope.builtin').find_files{
        cwd =  vim.fn.expand('%:p:h:h'),
        prompt_title = string.format("Recherche (-1): %s/", vim.fn.expand('%:p:h:h')),
    }
end

function FindFiles_2()
    require('telescope.builtin').find_files{
        cwd =  vim.fn.expand('%:p:h:h:h'),
        prompt_title = string.format("Recherche (-1): %s/", vim.fn.expand('%:p:h:h:h')),
    }
end
function FindFiles_3()
    require('telescope.builtin').find_files{
        cwd =  vim.fn.expand('%:p:h:h:h:h'),
        prompt_title = string.format("Recherche (-1): %s/", vim.fn.expand('%:p:h:h:h:h')),
    }
end

function FindFiles_Home(hidden_file)
    require('telescope.builtin').find_files{
        cwd =  vim.fn.expand(os.getenv("HOME")),
        prompt_title = string.format("Recherche (home): %s/", os.getenv("HOME")),
        hidden = hidden_file,
    }
end

function LiveGrep_Home()

    require('telescope.builtin').live_grep{
        search_dirs = {os.getenv("HOME")},
        prompt_title = os.getenv("HOME"),
    }
end
