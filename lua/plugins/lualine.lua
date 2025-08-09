return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filename',
            path = 1, -- 👈 Show relative path (use 2 for absolute path)
          },
        },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = {},
      },
    }
  end,
}
