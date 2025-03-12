return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	config = function()
	-- 		vim.cmd.colorscheme "catppuccin"
	-- 	end
	-- }
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").load()
		end
	}
}
