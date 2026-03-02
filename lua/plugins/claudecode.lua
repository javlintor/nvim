return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "Toggle Claude Code" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      desc = "Focus Claude Code" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",       desc = "Send to Claude",    mode = "v" },
    { "<leader>ao", "<cmd>ClaudeCodeDiffOpen<cr>",   desc = "Open diff" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  },
}
