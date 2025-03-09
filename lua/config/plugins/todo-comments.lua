return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		{
			"]t",
			function() require("todo-comments").jump_next() end,
			desc = "Jumpt to next todo comment"
		}
	},
	config = function()
		require("todo-comments").setup {}
	end,
	event = "VimEnter"
}
