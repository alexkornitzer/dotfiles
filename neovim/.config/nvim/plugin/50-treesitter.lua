vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

require("nvim-treesitter").install({
  "c",
  "elixir",
  "json",
  "lua",
  "rust",
  "svelte",
  "toml",
  "typescript",
  "zig"
})

vim.api.nvim_create_autocmd({ 'Filetype' }, {
  callback = function(event)
    local parsers = require('nvim-treesitter.parsers')
    if not parsers[event.match] then return end
    local ft = vim.bo[event.buf].ft
    local lang = vim.treesitter.language.get_lang(ft)
    require("nvim-treesitter").install({ lang }):await(function(err)
      if err then
        vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
        return
      end

      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end)
  end,
})
