return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
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

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
    local MiniFiles = require 'mini.files'
    MiniFiles.setup {}
    vim.keymap.set('n', '<leader>fe', function()
      if vim.bo.buftype == 'terminal' then
        MiniFiles.open()
        return
      end
      local filepath = vim.api.nvim_buf_get_name(0)
      MiniFiles.open(vim.fn.fnamemodify(filepath, ':p:h'))
    end, { desc = 'Open mini.files in current file dir' })

    -- Open in project root
    vim.keymap.set('n', '<leader>fE', function()
      MiniFiles.open()
    end, { desc = 'Open mini.files in project root' })
  end,
}
