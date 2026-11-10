return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    local actions = require 'telescope.actions'
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { 'node_modules', '.venv', 'uv.lock', 'package%-lock%.json', "%.git/.*", },
        path_display = { 'smart' },
        mappings = {
          n = {
            ['dd'] = actions.delete_buffer,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          additional_args = function()
            return { '--hidden', '--smart-case' }
          end,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>ss', function()
      builtin.buffers {
        sort_mru = true,
        ignore_current_buffer = true,
      }
    end, { desc = '[ ] Find existing buffers' })
    -- terminals are unlisted (see TermOpen autocmd), so <leader>ss skips them; this picker is the only place they show up
    vim.keymap.set('n', '<leader>tt', function()
      local terms = vim.tbl_filter(function(b)
        return vim.bo[b].buftype == 'terminal'
      end, vim.api.nvim_list_bufs())
      if #terms == 0 then
        return vim.notify('No terminal buffers', vim.log.levels.INFO)
      end
      table.sort(terms, function(a, b)
        return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
      end)
      require('telescope.pickers')
          .new({}, {
            prompt_title = 'Terminals',
            finder = require('telescope.finders').new_table {
              results = terms,
              entry_maker = function(b)
                local bufname = vim.api.nvim_buf_get_name(b)
                -- a name set with `:file foo` wins; otherwise show the shell's title
                local label = bufname:find('^term://') and (vim.b[b].term_title or bufname) or
                vim.fn.fnamemodify(bufname, ':t')
                local name = ('%d: %s'):format(b, label)
                return { value = b, bufnr = b, display = name, ordinal = name }
              end,
            },
            sorter = require('telescope.config').values.generic_sorter {},
          })
          :find()
    end, { desc = '[T]oggle [T]erminals' })
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
    -- search directories
    vim.keymap.set('n', '<leader>sD', function()
      builtin.find_files {
        prompt_title = '< Directories >',
        find_command = { 'fd', '--type', 'd', '--hidden', '--exclude', '.git' },
      }
    end, { desc = '[S]earch [D]irectories' })
  end,
}
