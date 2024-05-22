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
  end,
  init = function(_)
    local pylsp = require("mason-registry").get_package("python-lsp-server")
    pylsp:on("install:success", function()
      local function mason_package_path(package)
        local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
        return path
      end

      local path = mason_package_path("python-lsp-server")
      local command = path .. "/venv/bin/pip"
      local args = {
        "install",
        "-U",
        "pylsp-mypy",
        "pylsp-rope",
        "python-lsp-isort",
        "python-lsp-ruff",
      }

      require("plenary.job")
          :new({
            command = command,
            args = args,
            cwd = path,
          })
          :start()
    end)
  end,
}
