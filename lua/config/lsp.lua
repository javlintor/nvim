vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('<leader>gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    map('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_group = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(ev)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = ev.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- === Diagnostics ===
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
  },
}
--
-- -- -- === Server configs ===
-- -- Ruff
vim.lsp.config('ruff', {
  init_options = {
    settings = {
      configuration = '~/dotfiles/.ruff.toml',
    },
  },
})
vim.lsp.enable 'ruff'

-- Terraform
vim.lsp.enable 'terraform_lsp'

-- Astro
vim.lsp.config('astro', { filetypes = { 'astro' } })
vim.lsp.enable 'astro'

-- javascript & typescript
vim.lsp.config('ts_ls', { filetypes = { 'javascript', 'typescript' } })
vim.lsp.enable 'ts_ls'


-- Pyright
vim.lsp.config('pyright', {
  -- capabilities = capabilities,
  -- before_init = function(_, config)
  --   local venv_path = vim.fn.getcwd() .. '/.venv/bin/python'
  --   if vim.fn.executable(venv_path) == 1 then
  --     config.settings.python.pythonPath = venv_path
  --   end
  -- end,
  settings = {
    pyright = { disableOrganizeImports = true },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})
vim.lsp.enable 'pyright'
vim.lsp.config('sqruff', {
  cmd = { 'sqruff', 'lsp', '--config', vim.fn.expand '~/dotfiles/.sqruff' },
  filetypes = { 'sql' },
})

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
})
vim.lsp.enable('lua_ls')
