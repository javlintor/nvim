-- exit search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- move around windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- source current file
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>') -- <CR> simulates pressing enter
-- source current line
vim.keymap.set('n', '<space>x', ':.lua<CR>')
-- source selected section
vim.keymap.set('v', '<space>x', ':lua<CR>')
-- center text after <C-d> or <C-u>
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'G', 'Gzz', { noremap = true, silent = true })
-- source Session.vim
vim.keymap.set('n', '<leader>SS', '<cmd>source Session.vim<CR>', { noremap = true, silent = true, desc = '[S]ource [S]ession' })
-- smart delete buffer
vim.keymap.set('n', '<Space>bd', function()
  vim.api.nvim_command 'bp|sp|bn|bd'
end)
-- open diagnostics float
vim.keymap.set('n', '<leader>df', function()
  vim.diagnostic.open_float()
end, { noremap = true, silent = true })
-- for html or astro files, set indentation to 2
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'astro' },
  callback = function()
    local n_char = 2
    vim.opt_local.shiftwidth = n_char -- indentation width
    vim.opt_local.tabstop = n_char -- number of spaces a tab counts for
    vim.opt_local.softtabstop = n_char
  end,
})
-- edit ghostty configuration file
vim.keymap.set('n', '<leader>eg', function()
  vim.cmd('edit ' .. '/Users/jlinares/.config/ghostty/config')
end, { desc = '[E]edit [I]nit.lua' })
