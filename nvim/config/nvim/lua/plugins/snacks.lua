local ai_term = nil

return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      enabled = true,
      win = {
        position = "right",
        width = 0.4,
      },
    },
  },
  keys = {
    {
      "<leader>ai",
      function()
        if ai_term then
          ai_term:toggle()
          return
        end

        ai_term = Snacks.terminal("/home/marcos/.opencode/bin/opencode --port 3000")
      end,
      desc = "Toggle AI panel",
    },
  },
}
