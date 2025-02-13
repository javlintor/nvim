-- LSP Config
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    require("venv-selector").setup({
      auto_select = true, -- Automatically selects venv if only one is found
      name = ".venv", -- Looks for '.venv' by default
    })
  end,
})
