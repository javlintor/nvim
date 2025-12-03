return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>ds",
      "<cmd>Trouble symbols toggle win.position=bottom<cr>",
      desc = "Symbols (Trouble)",
    }
  }
}
