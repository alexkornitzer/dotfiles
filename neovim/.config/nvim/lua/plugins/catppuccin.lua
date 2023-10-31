-- Catppuccin: Soothing pastel theme for Vim
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  branch = 'main',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end
}
