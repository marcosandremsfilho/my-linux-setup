vim.cmd("set number")
vim.cmd("nnoremap <C-d> <C-d>zz")
vim.cmd("nnoremap <C-u> <C-u>zz")
vim.cmd("nnoremap n nzz")
vim.cmd("nnoremap N Nzz")
vim.cmd("nnoremap { {zz")
vim.cmd("nnoremap } }zz")
vim.cmd("nnoremap ]] ]]zz")

vim.cmd("nnoremap gd gdzz")
vim.g.mapleader = " "

vim.opt.colorcolumn = "120"

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#F28FAD" })  -- Cor rosa no Catppuccin
vim.api.nvim_command("match ExtraWhitespace /\\s\\+$/")

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e"
})

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"
