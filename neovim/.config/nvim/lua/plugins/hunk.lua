-- hunk.nvim: A tool for splitting diffs in Neovim
return {
  "julienvincent/hunk.nvim",
  cmd = { "DiffEditor" },
  config = function()
    require("hunk").setup()
  end,
}
