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
        search = bf_model,
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
  for model in content:gmatch("{{%s*ref%(['\"]([^'\"]+)['\"]%)%s*}}") do
    if not seen[model] then
      table.insert(models, model)
      seen[model] = true
    end
  end

  builtin.find_files(
    vim.tbl_extend(
      "force",
      {
        prompt_title = "1+" .. bf_model,
        find_command = {
          "fd",
          "--type", "f",
          "(" .. table.concat(models, "|") .. ")\\.(sql|csv)$",
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

  vim.cmd(action .. ' ' .. file_to_open)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  callback = function(event)
    local bufnr = event.buf

    -- Buffer-local user commands
    vim.api.nvim_buf_create_user_command(bufnr, "DBTUptreamModels", list_upstream_models, {})
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
