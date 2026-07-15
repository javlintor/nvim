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
-- center text after <C-d> or <C-u>
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'G', 'Gzz', { noremap = true, silent = true })
-- source Session.vim
vim.keymap.set('n', '<leader>SS', '<cmd>source Session.vim<CR>',
  { noremap = true, silent = true, desc = '[S]ource [S]ession' })
-- smart delete buffer
vim.keymap.set('n', '<Space>bd', function()
  vim.api.nvim_command 'bp|sp|bn|bd'
end)
-- open diagnostics float
vim.keymap.set('n', '<leader>df', function()
  vim.diagnostic.open_float()
end, { noremap = true, silent = true })
-- copy absolute file path
vim.keymap.set('n', '<leader>cA', function()
  local filepath = vim.fn.expand '%:p' -- full file path
  vim.fn.setreg('+', filepath)         -- copy to system clipboard
  vim.notify('File path copied: ' .. filepath)
end, { desc = 'Yanked absolute file path' })

-- copy relative file path (from workspace root)
vim.keymap.set('n', '<leader>cP', function()
  local filepath = vim.fn.expand '%:.' -- %:. gets the path relative to cwd
  vim.fn.setreg('+', filepath)         -- copy to system clipboard
  vim.notify('Relative path copied: ' .. filepath)
end, { desc = 'Yanked relative (to cwd) file path' })

-- copy file name
vim.keymap.set('n', '<leader>cp', function()
  local filepath = vim.fn.expand '%:t:r' -- %:t:r gets the filename without path and extension
  vim.fn.setreg('+', filepath)           -- copy to system clipboard
  vim.notify('File name copied: ' .. filepath)
end, { desc = 'Yanked file name' })
