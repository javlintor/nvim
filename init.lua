print("advent of neovim")

-- source current file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>") -- <CR> simulates pressing enter
-- source current line
vim.keymap.set("n", "<space>x", ":.lua<CR>")
-- source selected section
vim.keymap.set("v", "<space>x", ":lua<CR>")
