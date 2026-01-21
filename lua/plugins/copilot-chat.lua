return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "github/copilot.vim" },
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  opts = {
    headers = {
      user = '👤 You',
      assistant = '🤖 Copilot',
      tool = '🔧 Tool',
    },
    separator = '━━',
    prompts = {
      BuildUniTest = {
        prompt =
        'Convert the content into a csv file. Please remove the first column (@@, +++). Also remove nulls but keep commas. Transform any python datetime fields into human redable timestamp with format YYYY:MM:DDTHH:mm:ssZ. Also sort rows using the first column of compatible with type timestamp in ascending order.',
        description = 'Convert the output of a dbt unit test into a csv file',
        resources = { 'selection' }
      },
    }
  },
  keys = {
    { "<leader>zz", "<cmd>CopilotChatToggle<CR>", desc = "[Z]copilot [Z]chat Toggle", mode = "n" },
  },
}
