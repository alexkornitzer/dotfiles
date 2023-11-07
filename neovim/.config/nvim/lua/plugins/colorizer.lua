-- Nvim-Colorizer: Maintained fork of the fastest Neovim colorizer
return {
  'NvChad/nvim-colorizer.lua',
  config = function(_, opts)
    require 'colorizer'.setup(opts)
  end
}
