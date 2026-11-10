return {
  "folke/snacks.nvim",
  opts = {
    -- bigfile = { enabled = true },
    dashboard = {
      enabled = true,

      preset = {
        header = [[
     ██╗ █████╗ ██╗   ██╗██╗     ██╗███╗   ██╗████████╗ ██████╗ ██████╗
       ██║██╔══██╗██║   ██║██║     ██║████╗  ██║╚══██╔══╝██╔═══██╗██╔══██╗
       ██║███████║██║   ██║██║     ██║██╔██╗ ██║   ██║   ██║   ██║██████╔╝
  ██   ██║██╔══██║╚██╗ ██╔╝██║     ██║██║╚██╗██║   ██║   ██║   ██║██╔══██╗
  ╚█████╔╝██║  ██║ ╚████╔╝ ███████╗██║██║ ╚████║   ██║   ╚██████╔╝██║  ██║
   ╚════╝ ╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝
  ]],

        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Grep", action = ":Telescope live_grep" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
          { icon = " ", key = "c", desc = "Config", action = ":e $MYVIMRC" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    -- explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
