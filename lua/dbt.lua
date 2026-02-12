local file_picker = require("file_picker")

local function table_from_handle(handle)
  if not handle then
    print("Failed to run grep")
    return
  end

  local result = {}
  for line in handle:lines() do
    table.insert(result, line)
  end
  handle:close()
  return table
end

local function dbt_goto_relation(relation_type)
  local word = vim.fn.expand("<cword>")
  local cwd = vim.fn.getcwd()
  local lookup_dir = nil
  if relation_type == "model" then
    lookup_dir = cwd .. "/models"
  else
    lookup_dir = cwd .. "/macros"
  end

  local handle = io.popen('grep -rl --include="*.sql" "^" "' .. lookup_dir .. '" | grep "/' .. word .. '\\.sql$"')
  local result = table_from_handle(handle)
  if not result then
    return
  elseif #result == 0 then
    print("DBT model not found: " .. word)
    return
  elseif #result > 1 then
    print("Multiple matches found, opening first:")
    for _, path in ipairs(result) do print("  " .. path) end
  end

  vim.cmd("edit " .. result[1])
end

local function dbt_goto_model()
  dbt_goto_relation("model")
end

local function dbt_goto_macro()
  dbt_goto_relation("macro")
end

local function list_downstream_models()
  local builtin = require("telescope.builtin")
  local model = vim.fn.expand '%:t:r'
  builtin.grep_string({
    search = model,
    search_dirs = { "models" },
    additional_args = { "--glob", "*.sql" }
  })
end

-- Create the command
vim.api.nvim_create_user_command("DBTGoToModel", dbt_goto_model, {})
vim.api.nvim_create_user_command("DBTGoToMacro", dbt_goto_macro, {})
vim.api.nvim_create_user_command("DBTDownstreamModels", list_downstream_models, {})

-- Optional keymap
vim.api.nvim_set_keymap('n', '<leader>gm', ':DBTGoToModel<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':DBTGoToMacro<CR>', { noremap = true, silent = true })
