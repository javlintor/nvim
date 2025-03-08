return {
	{
		'echasnovski/mini.files',
		config = function()
			local minifiles = require "mini.files"
			minifiles.setup({
				windows = {
					preview = true,
					width_focus = 30,
					width_preview = 60,
				},
				options = {
					use_as_default_explorer = true,
					show_hidden = true
				}
			})
			-- open mini.files in current working directory
			vim.api.nvim_set_keymap(
				'n',
				'<leader>ee',
				':lua MiniFiles.open()<CR>',
				{
					desc = 'Open mini.files in current working directory',
					noremap = true,
					silent = true
				}
			)
			-- open mini.files in the directory where the buffer is located
			vim.api.nvim_set_keymap(
				'n',
				'<leader>ef',
				':lua MiniFiles.open(vim.fn.expand("%p:h"))<CR>',
				{
					desc = 'Open mini.files in current file directory',
					noremap = true,
					silent = true
				}
			)
		end
	},
	{
		'echasnovski/mini.statusline',
		config = function()
			local statusline = require 'mini.statusline'
			statusline.setup { use_icons = true }
		end
	},
	{
		'echasnovski/mini.icons',
		config = function()
			local miniicons = require "mini.icons"
			miniicons.setup({
				style = 'glyph'
			})
		end
	}
}
