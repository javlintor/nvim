local function list_downstream_models()
  local builtin = require("telescope.builtin")
  local model = vim.fn.expand '%:t:r'
  builtin.grep_string({
    search = model,
    search_dirs = { "models" },
    additional_args = { "--glob", "*.sql" }
  })
end

local function list_upstream_models()
  local builtin = require('telescope.builtin')
  local models = {}
  local seen = {}

  local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  for model in content:gmatch("{{%s*ref%(['\"]([^'\"]+)['\"]%)%s*}}") do
    if not seen[model] then
      table.insert(models, model)
      seen[model] = true
    end
  end

  builtin.find_files({
    find_command = {
      "fd",
      "--type", "f",
      "(" .. table.concat(models, "|") .. ")\\.(sql|csv)$",
      "models",
      "seeds",
    },
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "csv" },
  callback = function(event)
    local bufnr = event.buf

    -- Buffer-local user commands
    vim.api.nvim_buf_create_user_command(bufnr, "DBTUptreamModels", list_upstream_models, {})
    vim.api.nvim_buf_create_user_command(bufnr, "DBTDownstreamModels", list_downstream_models, {})

    -- Buffer-local keymaps
    vim.keymap.set("n", "<leader>su", list_upstream_models, {
      buffer = bufnr,
      silent = true,
      desc = "[S]earch [U]pstream models",
    })

    vim.keymap.set("n", "<leader>sd", list_downstream_models, {
      buffer = bufnr,
      silent = true,
      desc = "[S]earch [D]ownstream models",
    })
  end,
})
