local DBT_PROJECT = "ifco_digital_gwc"

local function base_picker_opts()
  return {
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.6,
    },
    sorting_strategy = "ascending",
  }
end

local function list_downstream_models()
  local builtin = require("telescope.builtin")
  local bf_model = vim.fn.expand '%:t:r'

  builtin.grep_string(
    vim.tbl_extend(
      "force",
      {
        prompt_title = bf_model .. "+1",
        search = string.format(
          [[\{\{\s*ref\(\s*['"]%s['"]\s*\)\s*\}\}]],
          bf_model
        ),
        use_regex = true,
        search_dirs = { "models" },
        additional_args = function()
          return { "--glob", "*.sql" }
        end,
      },
      base_picker_opts()
    ))
end

local function list_upstream_models()
  local builtin = require('telescope.builtin')
  local bf_model = vim.fn.expand '%:t:r'
  local models = {}
  local seen = {}

  local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  -- Cubre ref('m'), ref('pkg', 'm') y ref('m', v=2): el modelo es el último string entre comillas
  for args in content:gmatch("{{%s*ref%(([^)]-)%)%s*}}") do
    local model
    for quoted in args:gmatch("['\"]([^'\"]+)['\"]") do
      model = quoted
    end
    if model and not seen[model] then
      table.insert(models, model)
      seen[model] = true
    end
  end

  -- simple_cte([('alias', 'model'), ('alias', 'source', 'table')]): 2 strings = ref, 3 = source (se ignora)
  for block in content:gmatch("simple_cte%(%s*%[(.-)%]") do
    for tuple in block:gmatch("%(([^()]-)%)") do
      local strs = {}
      for quoted in tuple:gmatch("['\"]([^'\"]+)['\"]") do
        table.insert(strs, quoted)
      end
      local model = #strs == 2 and strs[2] or nil
      if model and not seen[model] then
        table.insert(models, model)
        seen[model] = true
      end
    end
  end

  if #models == 0 then
    vim.notify("No ref() or simple_cte() found in " .. bf_model, vim.log.levels.INFO)
    return
  end

  builtin.find_files(
    vim.tbl_extend(
      "force",
      {
        prompt_title = "1+" .. bf_model,
        find_command = {
          "fd",
          "--type", "f",
          "^(" .. table.concat(models, "|") .. ")\\.(sql|csv)$",
          "models",
          "seeds",
        },
      },
      base_picker_opts()
    )
  )
end

local function _model_documentation(action)
  local bf_model = vim.fn.expand('%:t:r')
  local model_dir = vim.fn.expand('%:h')
  local yml_file = model_dir .. '/_' .. bf_model .. '.yml'
  local yaml_file = model_dir .. '/_' .. bf_model .. '.yaml'

  local file_to_open = nil
  if vim.fn.filereadable(yml_file) == 1 then
    file_to_open = yml_file
  elseif vim.fn.filereadable(yaml_file) == 1 then
    file_to_open = yaml_file
  else
    vim.notify("No documentation file found for " .. bf_model, vim.log.levels.WARN)
    return
  end

  vim.cmd(action .. ' ' .. vim.fn.fnameescape(file_to_open))
end

local function compiled_model()
  -- Ruta relativa al cwd (raíz del proyecto dbt), p.ej. models/staging/foo.sql
  local compiled = "target/compiled/" .. DBT_PROJECT .. "/" .. vim.fn.expand('%:.')
  if vim.fn.filereadable(compiled) == 0 then
    vim.notify("No compiled file found: " .. compiled, vim.log.levels.WARN)
    return
  end
  vim.cmd("edit " .. vim.fn.fnameescape(compiled))
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  callback = function(event)
    local bufnr = event.buf

    -- Buffer-local user commands
    vim.api.nvim_buf_create_user_command(bufnr, "DBTUpstreamModels", list_upstream_models, {})
    vim.api.nvim_buf_create_user_command(bufnr, "DBTCompiledModel", compiled_model, {})
    vim.api.nvim_buf_create_user_command(bufnr, "DBTDownstreamModels", list_downstream_models, {})
    vim.api.nvim_buf_create_user_command(bufnr, "DBTEditModelDocs", function() _model_documentation("edit") end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "DBTVsplitModelDocs", function() _model_documentation("vsplit") end, {})

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

    vim.keymap.set("n", "<leader>mc", compiled_model, {
      buffer = bufnr,
      silent = true,
      desc = "open [M]odel [C]ompiled sql",
    })

    vim.keymap.set("n", "<leader>md", "<cmd>DBTEditModelDocs<CR>", {
      buffer = bufnr,
      silent = true,
      desc = "open [M]odel [D]ocumentation",
    })

    vim.keymap.set("n", "<leader>mD", "<cmd>DBTVsplitModelDocs<CR>", {
      buffer = bufnr,
      silent = true,
      desc = "open [M]odel [D]ocumentation (vsplit)",
    })
  end,
})
