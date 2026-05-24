return {
  "christoomey/vim-tmux-navigator",
  config = function()
    -- Smart navigation: prefer moving between Neovim windows (including terminal buffers),
    -- fall back to tmux navigation if the Neovim window didn't change.
    local dirs = { h = { w = 'h', t = 'Left' }, j = { w = 'j', t = 'Down' }, k = { w = 'k', t = 'Up' }, l = { w = 'l', t = 'Right' } }

    local function try_nav(dir)
      local cur = vim.api.nvim_get_current_win()
      local mode = vim.api.nvim_get_mode().mode

      -- If in terminal mode, switch to terminal-normal first so window commands work
      if mode == 't' then
        local esc = vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'n', false)
      end

      -- Try to move inside Neovim
      vim.cmd('wincmd ' .. dirs[dir].w)

      -- If we didn't move windows, fallback to tmux navigator
      if vim.api.nvim_get_current_win() == cur then
        vim.cmd('TmuxNavigate' .. dirs[dir].t)
      end
    end

    for k, _ in pairs(dirs) do
      vim.keymap.set({ 'n', 't' }, '<C-' .. k .. '>', function() try_nav(k) end, { silent = true })
    end
  end,
}
