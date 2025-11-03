-- Catppuccin: Soothing pastel theme for Vim
return {
  'filipjanevski/0x96f.nvim',
  name = '0x96f',
  branch = 'main',
  lazy = false,
  priority = 1000,
  config = function()
    require("0x96f").setup()
    vim.cmd.colorscheme("0x96f")
  end
}
