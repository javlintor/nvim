return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	config = function()
		require("telescope").setup {
			defaults = {
				path_display = { "tail" },
				file_ignore_patterns = { ".git" }
			},
			pickers = {
				find_files = {
					theme = "ivy",
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end
				}
			},
			extensions = {
				fzf = {}
			}
		}
		require("telescope").load_extension('fzf')
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set(
			'n',
			'<leader>en',
			function()
				builtin.find_files { cwd = vim.fn.stdpath("config") }
			end,
			{ desc = 'Edit Neovim' }
		)
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	end
}
