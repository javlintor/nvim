return {
  'catppuccin/nvim',
  name = 'catppuccin',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin-frappe'
  end,
}
