vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})
-- Enable line numbers when entering normal buffers
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype == '' then
      vim.wo.number = true
      vim.wo.relativenumber = true -- Optional
      vim.opt.scroll = 5
      vim.opt.scrolloff = 10
    end
  end,
})

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vertical colorcolumn for python files in column 100
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  command = 'setlocal colorcolumn=100',
})

-- copy absolute file path
vim.keymap.set('n', '<leader>cP', function()
  local filepath = vim.fn.expand '%:p' -- full file path
  vim.fn.setreg('+', filepath) -- copy to system clipboard
  vim.notify('File path copied: ' .. filepath)
end, { desc = 'Yanked absolute file path' })

-- copy file name
vim.keymap.set('n', '<leader>cp', function()
  local filepath = vim.fn.expand '%:t:r' -- %:t:r gets the filename without path and extension
  vim.fn.setreg('+', filepath) -- copy to system clipboard
  vim.notify('File name copied: ' .. filepath)
end, { desc = 'Yanked file name' })

-- let nvim know which python interpreter to use
vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  callback = function()
    local venv_path = vim.fn.getcwd() .. '/.venv'
    local python_bin = venv_path .. '/bin/python'
    print(vim.fn.filereadable(python_bin))
    if vim.fn.filereadable(python_bin) == 1 then
      vim.env.VIRTUAL_ENV = venv_path
      vim.env.PATH = venv_path .. '/bin:' .. vim.env.PATH
      vim.g.python3_host_prog = python_bin
    end
  end,
})

-- for html or astro files, set indentation to 2
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'astro' },
  callback = function()
    local n_char = 2
    vim.opt_local.tabstop = n_char
  end,
})
