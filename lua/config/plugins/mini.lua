return {
	{
		'echasnovski/mini.nvim',
		config = function()
			local statusline = require 'mini.statusline'
			statusline.setup { use_icons = ture }
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
			local miniicons = require "mini.icons"
			miniicons.setup({
				style = 'glyph'
			})
		end
	}
}
