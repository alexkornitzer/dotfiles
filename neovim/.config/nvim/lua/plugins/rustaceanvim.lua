return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  opts = {
    server = {
      on_attach = function(client, bufnr)
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.buf.inlay_hint(bufnr, true)
        end
      end,
      settings = {
        ['rust-analyzer'] = {
          check = {
            command = "clippy"
          }
        }
      }
    },
    tools = {
      hover_actions = {
        replace_builtin_hover = false,
      },
    },
  },
  config = function(_, opts)
    vim.g.rustaceanvim = opts
  end
}
