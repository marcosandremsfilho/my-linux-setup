return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black.with({
          extra_args = { "--line-length", "120" },
        }),
        null_ls.builtins.formatting.clang_format.with({
          command = "clang-format-15",
          extra_args = {
            "-style={BasedOnStyle: Google, IndentWidth: 2, ColumnLimit: 120, AccessModifierOffset: -1, SpacesBeforeTrailingComments: 2, BreakBeforeBraces: Attach, UseTab: Never, PointerAlignment: Left, NamespaceIndentation: None, AllowShortFunctionsOnASingleLine: Empty, SpaceAfterCStyleCast: true, DerivePointerAlignment: false, AlwaysBreakTemplateDeclarations: Yes, ConstructorInitializerAllOnOneLineOrOnePerLine: true, SpacesInAngles: false, BreakConstructorInitializersBeforeComma: true, SortIncludes: true, IncludeBlocks: Preserve}" },
        }),
      }
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

    vim.keymap.set("n", "<leader>gb", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local handle = io.popen("git diff -U0 " .. filename)
      local result = handle:read("*a")
      handle:close()

      local ranges = {}
      for hunk in result:gmatch("@@ [^@]* @@") do
        local start, count = hunk:match("+(%d+),?(%d*)")
        if start then
          local line = tonumber(start)
          local lines = tonumber(count) or 1
          table.insert(ranges, { line = line, lines = lines })
        end
      end

      for _, range in ipairs(ranges) do
        local cmd = string.format(
          "clang-format-15 -style='{BasedOnStyle: Google, IndentWidth: 2, ColumnLimit: 120, AccessModifierOffset: -1, SpacesBeforeTrailingComments: 2, BreakBeforeBraces: Attach, UseTab: Never, PointerAlignment: Left, NamespaceIndentation: None, AllowShortFunctionsOnASingleLine: Empty, SpaceAfterCStyleCast: true, DerivePointerAlignment: false, AlwaysBreakTemplateDeclarations: Yes, ConstructorInitializerAllOnOneLineOrOnePerLine: true, SpacesInAngles: false, BreakConstructorInitializersBeforeComma: true, SortIncludes: true, IncludeBlocks: Preserve}' -lines=%d:%d -i %s",
          range.line,
          range.line + range.lines - 1,
          filename
        )
        os.execute(cmd)
      end

      vim.cmd("edit!") -- reload buffer
    end, { desc = "Formatar apenas linhas alteradas com clang-format" })
  end
}
