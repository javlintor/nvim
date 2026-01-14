local function dbt_goto_relation(relation_type)
  local word = vim.fn.expand("<cword>")
  local cwd = vim.fn.getcwd()
  local lookup_dir = nil
  if relation_type == "model" then
    lookup_dir = cwd .. "/models"
  else
    lookup_dir = cwd .. "/macros"
  end

  -- Use grep to search recursively for the file
  -- The -l option lists only filenames that match
  local handle = io.popen('grep -rl --include="*.sql" "^" "' .. lookup_dir .. '" | grep "/' .. word .. '\\.sql$"')
  if not handle then
    print("Failed to run grep")
    return
  end

  local result = {}
  for line in handle:lines() do
    table.insert(result, line)
  end
  handle:close()

  if #result == 0 then
    print("DBT model not found: " .. word)
    return
  elseif #result > 1 then
    print("Multiple matches found, opening first:")
    for _, path in ipairs(result) do print("  " .. path) end
  end

  -- Open the first match
  vim.cmd("edit " .. result[1])
end

local function dbt_goto_model()
  dbt_goto_relation("model")
end

local function dbt_goto_macro()
  dbt_goto_relation("macro")
end

-- Create the command
vim.api.nvim_create_user_command("DBTGoToModel", dbt_goto_model, {})
vim.api.nvim_create_user_command("DBTGoToMacro", dbt_goto_macro, {})

-- Optional keymap
vim.api.nvim_set_keymap('n', '<leader>gm', ':DBTGoToModel<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':DBTGoToMacro<CR>', { noremap = true, silent = true })
