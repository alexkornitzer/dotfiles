-- Tmux.nvim: tmux integration for nvim features pane movement and resizing from within nvim.
return {
  'aserowy/tmux.nvim',
  config = function()
    vim.keymap.set("n", "<C-h>", "lua require'tmux'.move_left()", { desc = "Go to left window" })
    vim.keymap.set("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
    vim.keymap.set("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
    vim.keymap.set("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })

    require("tmux").setup()
  end
}
