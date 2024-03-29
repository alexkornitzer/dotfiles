-- Guard: async fast minimalist plugin make format easy in neovim
return {
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
  },
  opts = {
    fmt_on_save = true,
    lsp_as_default_formatter = true,
  },
  config = function(_, opts)
    local ft = require('guard.filetype')

    ft('javascript,typescript'):fmt('prettier')

    require('guard').setup(opts)
  end
}
