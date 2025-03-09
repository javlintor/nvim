local capabilities = require("blink.cmp").get_lsp_capabilities()

local function lua_ls_setup()
	require("lspconfig").lua_ls.setup {
		capabilities = capabilities
	}
end

local function python_ls_setup()
	local pythonPath = "./.venv/bin/python"
	if vim.fn.executable(pythonPath) == 0 then
		pythonPath = vim.fn.exepath("python3")
	end
	require("lspconfig").pyright.setup {
		settings = {
			python = {
				pythonPath = pythonPath
			}
		},
		capabilities = capabilities
	}
end

local function sqlls_ls_setup()
	require 'lspconfig'.sqlls.setup {
		capabilities = capabilities
	}
end

local function create_lsp_attach_autocmd()
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

local function terraform_ls_setup()
	require("lspconfig").terraform_lsp.setup {}
end

local function set_keymaps()
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variable" })
	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
	vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Go to references" })
end


return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'saghen/blink.cmp',
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
			sqlls_ls_setup()
			create_lsp_attach_autocmd()
			terraform_ls_setup()
			set_keymaps()
		end,
	}
}
