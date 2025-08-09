return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  keys = {
    {
      '<leader>fe',
      function()
        local mf = require 'mini.files'
        if vim.bo.buftype == 'terminal' then
          mf.open()
          return
        end
        local filepath = vim.api.nvim_buf_get_name(0)
        MiniFiles.open(vim.fn.fnamemodify(filepath, ':p:h'))
      end,
      mode = 'n',
      desc = 'Open mini.files in current file dir',
    },
    {
      '<leader>fE',
      function()
        local mf = require 'mini.files'
        mf.open(vim.fn.getcwd())
      end,
      mode = 'n',
      desc = 'Open mini.files in project root',
    },
  },
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    require('mini.files').setup()
  end,
}
