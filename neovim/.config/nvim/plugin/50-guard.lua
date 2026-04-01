vim.pack.add({
  'https://github.com/nvimdev/guard-collection',
  'https://github.com/nvimdev/guard.nvim'
})

local ft = require('guard.filetype')

if vim.fn.executable('erlfmt') == 1 then
  ft('erlang'):fmt({
    cmd = 'erlfmt',
    args = { "-" },
    stdin = true,
  })
end

ft('javascript,typescript'):fmt('prettier')
ft('json'):fmt('jq')
ft("python"):fmt('ruff')
ft('yaml'):fmt('yamlfix'):env({ YAMLFIX_SECTION_WHITELINES = '1' })

vim.g.guard_config = {
  fmt_on_save = true,
  lsp_as_default_formatter = true,
  save_on_fmt = true,
}
