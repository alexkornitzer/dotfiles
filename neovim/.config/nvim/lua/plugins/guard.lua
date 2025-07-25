-- Guard: async fast minimalist plugin make format easy in neovim
return {
  "nvimdev/guard.nvim",
  dependencies = {
    "nvimdev/guard-collection",
  },
  config = function(_, _)
    local ft = require('guard.filetype')

    ft("python"):fmt({
      fn = function(buf, range)
        vim.lsp.buf.format({
          buffer = buf,
          range = range,
          async = true,
          name = "ruff",
        })
      end
    })
    ft('javascript,typescript'):fmt('prettier')
    ft('json'):fmt('jq')
    ft('yaml'):fmt('yamlfix'):env({ YAMLFIX_SECTION_WHITELINES = '1' })

    vim.g.guard_config = {
      fmt_on_save = true,
      lsp_as_default_formatter = true,
      save_on_fmt = true,
    }
  end
}
