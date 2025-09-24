return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    local apps = { 'ops_washing', 'retail_forecaster' }

    dap.configurations.python = dap.configurations.python or {}
    for _, app in ipairs(apps) do
      dap.adapters[app] = {
        type = 'executable',
        command = 'uv',
        args = {
          'run',
          '--group',
          app,
          '--env-file',
          string.format('.env-files/%s.env', app),
          'python',
          '-m',
          'debugpy.adapter',
        },
      }

      table.insert(dap.configurations.python, {
        type = app,
        request = 'launch',
        name = 'Streamlit ' .. app,
        module = 'streamlit',
        args = {
          'run',
          'src/apps/main.py',
          '--server.port',
          '8080',
          '--',
          '--app',
          app,
        },
      })
    end
    table.insert(dap.configurations.python, {
      type = 'ops_washing',
      request = 'launch',
      name = 'Launch script ops_washing',
      program = '${file}',
    })

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
  end,
  keys = {
    {
      '<leader>B',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'DAP: Toggle Breakpoint',
    },
    {
      '<leader>bb',
      function()
        local dap = require 'dap'
        if dap.session() then
          dap.terminate()
          vim.notify('DAP session terminated', vim.log.levels.INFO)
        else
          dap.continue()
          vim.notify('DAP session started', vim.log.levels.INFO)
        end
      end,
      desc = 'DAP: Continue or Terminate',
    },
  },
}
