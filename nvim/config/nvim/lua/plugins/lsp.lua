return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls", "pyright", "clangd" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = { "prettier" } },
        "neovim/nvim-lspconfig",
    },
}
