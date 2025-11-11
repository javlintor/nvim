return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto',
    },
    sections = {
      lualine_a = {
        function()
          local mode_map = {
            n = 'N',
            i = 'I',
            v = 'V',
            V = 'VL',
            [''] = 'VB',
            c = 'C',
            R = 'R',
            t = 'T',
          }
          local mode = vim.fn.mode()
          return mode_map[mode] or mode
        end,
      },
      lualine_b = {
        'branch',
      },
      lualine_c = {
        {
          'filename',
          path = 1, -- relative path (2 for absolute)
        },
      },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {},
    },
  },
}
