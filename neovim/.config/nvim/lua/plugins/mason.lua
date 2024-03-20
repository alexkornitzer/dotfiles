-- mason: Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters
return {
  'williamboman/mason.nvim',
  branch = 'main',
  dependencies = {
    'williamboman/mason-lspconfig.nvim'
  },
  lazy = false,
  priority = 100,
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()
  end
}
