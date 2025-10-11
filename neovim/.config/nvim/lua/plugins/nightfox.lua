-- Catppuccin: Soothing pastel theme for Vim
return {
  'edeneast/nightfox.nvim',
  name = 'nightfox',
  branch = 'main',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("carbonfox")
  end
}
