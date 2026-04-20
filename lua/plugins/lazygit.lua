vim.g.lazygit_floating_window_scaling_factor = 0.95

return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>gg",
      function()
        vim.env.SKIP = 'install-dbt-deps'
        vim.cmd('LazyGit')
      end,
      desc = "LazyGit"
    },
    { "<leader>gf", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit" }
  }
}
