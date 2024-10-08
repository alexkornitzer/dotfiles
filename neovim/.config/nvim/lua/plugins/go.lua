-- Go: G'day Nvimer, Joyful Gopher: Discover the Feature-Rich Go Plugin for Neovim
return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  event = { "CmdlineEnter" },
  ft = { "go", 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require("go").setup({
      lsp_cfg = false,
      lsp_inlay_hints = {
        enable = false,
      },
    })
  end,
}
