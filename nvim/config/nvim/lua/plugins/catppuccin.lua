-- ~/.config/nvim/lua/plugins/catppuccin.lua
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- ou "latte", "frappe", "macchiato"
      transparent_background = false,
      integrations = {
        treesitter = true,
        mason = true,
        cmp = true,
        telescope = true,
        which_key = true,
        gitsigns = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
