--
-- Lazy Plugin Manager
--

-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


--
-- Options
--

-- Round windows
vim.o.winborder = 'rounded'

-- Enable true colour support
vim.opt.termguicolors = true

-- Sync clipboard with system
--vim.opt.clipboard = "unnamedplus"

-- Disable mouse
vim.opt.mouse = ""

-- Set completion
vim.opt.completeopt = "menu,menuone,noinsert,noselect"

-- Turn on line numbers
vim.opt.number = true

-- Set up indent and tab settings
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Set scroll settings
vim.opt.scrolloff = 10

-- Always show tabline
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.showtabline = 2

-- Use ripgrep
vim.opt.grepprg = "rg --vimgrep"


--
-- Plugins
--

-- Load Plugins
require("lazy").setup("plugins", {
  ui = {
    icons = {
      cmd = "",
      config = "",
      event = "",
      ft = "",
      init = "",
      import = "",
      keys = "",
      lazy = "",
      loaded = "●",
      not_loaded = "○",
      plugin = "",
      runtime = "",
      require = "",
      source = "",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  }
})


--
-- Keymaps
--

-- Silent keymap option
local opts = { silent = true, noremap = true }

-- Find merge conflict markers
vim.keymap.set('', '<leader>fc', [[/\v^[<\|=>]{7}<CR>]], opts)

-- Run python's jtool and set the filetype
vim.keymap.set('n', '<leader>jt', '<Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>', opts)

-- Window Keymap
-- NOTE: Handled by tmux.nvim
--vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
--vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
--vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
--vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Buffer keymap
--vim.keymap.set("n", "<C-H>", "<C-W><C-H>", opts)
--vim.keymap.set("n", "<C-J>", "<C-W><C-J>", opts)
--vim.keymap.set("n", "<C-K>", "<C-W><C-K>", opts)
--vim.keymap.set("n", "<C-L>", "<C-W><C-L>", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

--
-- Autocommands
--

-- Turn on spelling for certain filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "tex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Remember cursor location
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*.*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

-- Set tabs for some file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gdscript" },
  callback = function()
    vim.opt.expandtab = false
  end,
})
