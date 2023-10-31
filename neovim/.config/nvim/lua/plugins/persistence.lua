-- Persistence: Simple session management for Neovim
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
  },
  config = function()
    -- restore the session for the current directory
    vim.keymap.set("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

    -- restore the last session
    vim.keymap.set("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

    -- stop Persistence => session won't be saved on exit
    vim.keymap.set("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
  end
}
