return	{
	  "stianlyng/neoranger.nvim",
	  config = function()
	    require("neoranger").setup()
	  -- Toggle ranger in current working directory
	vim.keymap.set("n", "<leader>rc", function()
	  require("neoranger").toggleFloat()
	end, { desc = "Open ranger" })

	-- Toggle ranger in current file's directory
	vim.keymap.set("n", "<leader>rr", function()
	  require("neoranger").toggleFloat({ cwd = vim.fn.expand("%:p:h") })
	end, { desc = "Ranger in file dir" })
	  end,
}
