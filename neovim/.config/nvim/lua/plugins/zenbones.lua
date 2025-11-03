-- Catppuccin: Soothing pastel theme for Vim
return {
  'zenbones-theme/zenbones.nvim',
  name = 'Zenbones',
  branch = 'main',
  dependencies = "rktjmp/lush.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('zenbones')
  end
}
