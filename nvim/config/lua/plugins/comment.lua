return {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function()
    require('Comment').setup({
       toggler = {
        ---Line-comment toggle keymap
        line = '<leader>cll',
        ---Block-comment toggle keymap
        block = '<leader>cbb',
    },
      opleader = {
        ---Line-comment keymap
        line = '<leader>cl',
        ---Block-comment keymap
        block = '<leader>cb',
      },
    })
  end
}
