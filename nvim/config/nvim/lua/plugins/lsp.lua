return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "bashls" },
        automatic_installation = true,
      })

      -- Caminho seguro para os binários do Mason
      local data_path = vim.fn.stdpath("data") or (os.getenv("HOME") .. "/.local/share/nvim")
      local mason_path = data_path .. "/mason/bin/"

      ----------------------------------------------------------------
      -- 🧠 Nova API Neovim 0.11+: usar vim.lsp._config
      ----------------------------------------------------------------
      local configs = vim.lsp._config

      -- Se ainda não existir um config registrado, criamos
      if not configs.lua_ls then
        configs.lua_ls = {
          cmd = { mason_path .. "lua-language-server" },
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        }
      end

      if not configs.bashls then
        configs.bashls = {
          cmd = { mason_path .. "bash-language-server", "start" },
        }
      end

      -- Inicia os servidores
      vim.lsp.start(configs.lua_ls)
      vim.lsp.start(configs.bashls)
    end,
  },
}
