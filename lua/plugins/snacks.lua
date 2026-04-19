return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      enabled = true,
    }
  },
  init = function()
    vim.api.nvim_create_user_command("Term", function()
      Snacks.terminal.toggle()
    end, {})
  end,
}
