local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- telescope.load_extension('media_files')
telescope.load_extension('fzy_native')
telescope.load_extension('neoclip')
telescope.load_extension('projects')
telescope.load_extension("flutter")

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = {"./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*"},
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
