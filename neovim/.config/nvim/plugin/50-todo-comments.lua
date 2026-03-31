vim.pack.add({
  'https://github.com/folke/todo-comments.nvim'
})

require('todo-comments').setup({
  keywords = {
    FIX = { icon = "F " },
    TODO = { icon = "T " },
    HACK = { icon = "H " },
    WARN = { icon = "W " },
    PERF = { icon = "P " },
    NOTE = { icon = "  " },
    TEST = { icon = "⏲ " },
  }
})
