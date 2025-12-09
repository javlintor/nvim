return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      window = { layout = "horizontal" },
    },
    keys = {
      { "<leader>zz", "<cmd>CopilotChatToggle<CR>",   desc = "[Z]copilot [Z]chat Toggle",   mode = "n" },
      { "<leader>ze", "<cmd>CopilotChatExplain<CR>",  desc = "[Z]copilot [E]xplain",        mode = "v" },
      { "<leader>zo", "<cmd>CopilotChatOptimize<CR>", desc = "[Z]copilot [O]ptimize",       mode = "v" },
      { "<leader>zt", "<cmd>CopilotChatTests<CR>",    desc = "[Z]copilot generate [T]ests", mode = "v" }
    }
  },
}
