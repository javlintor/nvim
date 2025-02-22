print("advent of neovim")

-- source current file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- <CR> simulates pressing enter
-- source current line
vim.keymap.set("n", "<space>x", ":.lua<CR>")
-- source selected section
vim.keymap.set("v", "<space>x", ":lua<CR>")

-- highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
