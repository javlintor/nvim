require 'my_config.settings'
require 'my_config.keymaps'
require 'my_config.autocommands'

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Configure and install plugins
require('lazy').setup {
  require 'my_config.plugins.vim-sleuth',
  require 'my_config.plugins.gitsigns',
  require 'my_config.plugins.which-key',
  -- fuzzy finder
  require 'my_config.plugins.telescope',
  -- LSP Plugins
  require 'my_config.plugins.lazydev',
  require 'my_config.plugins.nvim-lspconfig',
  -- autoformat
  require 'my_config.plugins.conform',
  -- autocompletion
  require 'my_config.plugins.nvim-cmp',
  -- Highlight todo, notes, etc in comments
  require 'my_config.plugins.todo-comments',
  -- mini: a collection of various small independent plugins/modules
  require 'my_config.plugins.mini',
  -- Highlight, edit, and navigate code
  require 'my_config.plugins.nvim-treesitter',
  -- gitblame
  require 'my_config.plugins.blame',
  -- lazygit
  require 'my_config.plugins.lazygit',
  -- trouble
  require 'my_config.plugins.trouble',
  -- color scheme
  require 'my_config.plugins.catpuccin',
  -- nvim-dap: debug adapter protocol
  require 'my_config.plugins.nvim-dap',
  require 'my_config.plugins.nvim-dap-ui',
  -- csv views
  require 'my_config.plugins.csvview',
  -- status line
  require 'my_config.plugins.lualine',
}
