local ai_term = nil

local function get_opencode_command()
  local cmd = vim.env.OPENCODE_CMD or vim.g.opencode_cmd
  if cmd and cmd ~= vim.NIL then
    return cmd
  end

  local bin = vim.env.OPENCODE_BIN or vim.g.opencode_bin or "opencode"
  local port = vim.env.OPENCODE_PORT or vim.g.opencode_port or 3000

  port = tostring(port)

  return string.format('%s --port %s', bin, port)
end

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

        local cmd = get_opencode_command()
        ai_term = Snacks.terminal(cmd)
      end,
      desc = "Toggle AI panel",
    },
  },
}
