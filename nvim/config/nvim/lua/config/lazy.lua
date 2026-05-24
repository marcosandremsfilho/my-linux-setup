-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("nnoremap <C-d> <C-d>zz")
vim.cmd("nnoremap <C-u> <C-u>zz")
vim.cmd("nnoremap n nzz")
vim.cmd("nnoremap N Nzz")
vim.cmd("nnoremap { {zz")
vim.cmd("nnoremap } }zz")
vim.cmd("nnoremap ]] ]]zz")
vim.cmd("nnoremap gd gdzz")

vim.opt.colorcolumn = "120"

vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#F28FAD" })  -- Cor rosa no Catppuccin
vim.api.nvim_command("match ExtraWhitespace /\\s\\+$/")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e"
})

-- Ensure files changed on disk are auto-reloaded in open buffers.
-- Only check/reload when the buffer has no unsaved changes to avoid
-- overwriting in-memory edits.
vim.o.autoread = true

local function try_checktime()
  if vim.bo.modifiable and not vim.bo.modified then
    -- silent! avoids noisy messages when nothing changed
    vim.cmd("silent! checktime")
  end
end

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "BufWinEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = try_checktime,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk: reloaded", vim.log.levels.INFO)
  end,
})

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"

-- Terminal mode navigation
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move left (terminal)" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move right (terminal)" })

-- Setup lazy.nvim
require("lazy").setup("plugins")
