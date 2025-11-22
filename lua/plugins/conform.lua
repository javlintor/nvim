return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, sql = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 50000,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      markdown = { 'markdownlint' },
      css = { 'prettier' },
      html = { 'prettier' },
      -- TODO: configure sql formater
      -- sql = { 'sqruff' },
      -- j2 = { 'sqruff' },
      -- jinja = { 'sqruff' },
      json = { 'prettier' },
      javascript = { 'prettier' },
      jsx = { 'prettier' },
      javascriptreact = { 'prettier' }, -- Just in case
      astro = { 'prettier' },
      terraform = { 'terraform_fmt' },
      tf = { 'terraform_fmt' },
      hcl = { 'terraform_fmt' },
    },

    ruff_fix = {
      args = {
        'check',
        '--fix',
        '--config',
        vim.fn.expand '~/.dotfiles/.ruff.toml',
        '--stdin-filename',
        '$FILENAME',
        '-',
      },
    },
  },
}
