return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'auto',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          function()
            -- Get the current working directory
            local cwd = vim.fn.getcwd()
            -- Extract just the folder name (repo name)
            return vim.fn.fnamemodify(cwd, ':t')
          end,
          icon = '', -- folder/repo icon (requires nvim-web-devicons)
          color = { fg = '#ffffff' },
        },
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
