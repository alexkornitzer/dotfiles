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

    ft("python"):fmt({
      fn = function(buf, range)
        vim.lsp.buf.format({
          buffer = buf,
          range = range,
          async = true,
          name = "ruff_lsp",
        })
      end
    })
    ft('javascript,typescript'):fmt('prettier')
    ft('yaml'):fmt({
      cmd = 'yamlfix',
      args = { '-' },
      stdin = true,
    }):env({ YAMLFIX_SECTION_WHITELINES = '1' })

    require('guard').setup(opts)
  end
}
