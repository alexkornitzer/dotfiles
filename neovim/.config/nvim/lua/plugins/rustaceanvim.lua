return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  opts = {
    server = {
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
