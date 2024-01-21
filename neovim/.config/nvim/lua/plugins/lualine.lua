-- Lualine: A blazing fast and easy to configure neovim statusline plugin written in pure lua.
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = '|', right = '|' },
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          icon = '⎇',
        },
        {
          'diff',
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed
              }
            end
          end
        },
        {
          'diagnostics',
          sources = { 'nvim_lsp' },
          symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' }
        }
      },
      lualine_c = { 'filename' },
      lualine_x = {
        function()
          local venv = vim.env.VIRTUAL_ENV
          if venv then
            local params = {}
            string.gsub(venv, '[^' .. '/' .. ']+', function(w) table.insert(params, w) end)
            return params[#params]
          else
            return
          end
        end,
        'encoding',
        {
          'fileformat',
          symbols = {
            unix = 'unix',
            dos = 'dos',
            mac = 'mac'
          }
        },
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    tabline = {
      lualine_a = {
        {
          'tabs',
          max_length = vim.o.columns,
          mode = 2
        }
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
  },
  config = function(_, opts)
    require('lualine').setup(opts)
  end
}
