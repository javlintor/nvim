return {
  'catppuccin/nvim',
  name = 'catppuccin',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
