return {
	{
		enabled = false,
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim',  -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
			vim.keymap.set("n", "H", "<cmd>BufferPrevious<CR>")
			vim.keymap.set("n", "L", "<cmd>BufferNext<CR>")
		end,
		opts = {
		},
		version = '^1.0.0',
	}
}
