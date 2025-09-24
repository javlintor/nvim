vim.api.nvim_create_user_command('Term', function(opts)
  -- If we're already inside a terminal buffer → create a new terminal
  if vim.bo.buftype == 'terminal' then
    vim.cmd('terminal ' .. (opts.args or ''))
    return
  end

  -- Otherwise, look for an existing terminal buffer
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buftype == 'terminal' then
      -- Jump to a window showing that buffer
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == bufnr then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
      -- If not visible, open it in the current window
      vim.api.nvim_set_current_buf(bufnr)
      return
    end
  end

  -- No terminal buffer exists → create one
  vim.cmd('terminal ' .. (opts.args or ''))
end, { nargs = '*' })

-- Make :term point to our smart :Term
vim.cmd 'cabbrev term Term'
