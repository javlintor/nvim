-- just provide defaults to configure and interact with lsp servers
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			require("lspconfig").lua_ls.setup {}
			local venv_path = "./.venv/bin/python"
			require("lspconfig").pyright.setup {
				settings = {
					python = {
						pythonPath = venv_path
					}
				}
			}
		end,
	}
}
