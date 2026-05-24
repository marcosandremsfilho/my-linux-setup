  return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    -- Provide server hooks that reuse the Snacks terminal helpers (if available)
    -- If snacks exposed a command helper, use it so opencode and snacks start the same process.
    local snacks_cmd = nil
    if vim.g.opencode_snacks and vim.g.opencode_snacks.get_command then
      snacks_cmd = vim.g.opencode_snacks.get_command()
    end

    vim.g.opencode_opts = {
      server = {
        -- Use the same command discovered by snacks. If available, provide start/stop/toggle
        -- implementations that call snacks' helpers so only one opencode process is started.
        start = function()
          if vim.g.opencode_snacks and vim.g.opencode_snacks.start then
            pcall(vim.g.opencode_snacks.start)
            return
          end
          -- Fallback: attempt to open a terminal with the same command
          if snacks_cmd then
            vim.cmd("split | terminal " .. snacks_cmd)
          end
        end,
        stop = function()
          if vim.g.opencode_snacks and vim.g.opencode_snacks.stop then
            pcall(vim.g.opencode_snacks.stop)
          end
        end,
        toggle = function()
          if vim.g.opencode_snacks and vim.g.opencode_snacks.start then
            -- Start will toggle open the terminal. If already open, snacks' terminal.toggle handles it.
            pcall(vim.g.opencode_snacks.start)
            return
          end
          if snacks_cmd then
            vim.cmd("split | terminal " .. snacks_cmd)
          end
        end,
      },
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Select opencode…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
