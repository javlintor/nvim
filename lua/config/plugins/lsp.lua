local function lua_ls_setup()
	require("lspconfig").lua_ls.setup {}
end

local function python_ls_setup()
	local venv_path = "./.venv/bin/python"
	require("lspconfig").pyright.setup {
		settings = {
			python = {
				pythonPath = venv_path
			}
		}
	}
end

local function general_ls_setup()
	vim.keymap.set("n", "<space>cf", function() vim.lsp.buf.format() end)
	vim.api.nvim_create_autocmd('LspAttach',
		{
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then return end
				if client.supports_method('textDocument/formatting') then
					vim.api.nvim_create_autocmd(
						'BufWritePre',
						{
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end,
						}
					)
				end
			end,
		}
	)
end

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
			lua_ls_setup()
			python_ls_setup()
			general_ls_setup()
		end,
	}
}
