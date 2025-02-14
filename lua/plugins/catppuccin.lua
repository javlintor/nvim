return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  options = function()
    vim.cmd("colorscheme catppuccin")
  end,
}
