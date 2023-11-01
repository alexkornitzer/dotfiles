-- Telescope: Find, Filter, Preview, Pick. All lua, all the time.
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "debugloop/telescope-undo.nvim"
  },
  config = function()
    require('telescope').load_extension('fzf')
    require("telescope").load_extension("undo")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
  end,
}
