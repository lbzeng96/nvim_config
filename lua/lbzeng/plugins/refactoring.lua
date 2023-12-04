return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	config = function()
		require("refactoring").setup()

		local keymap = vim.keymap
		keymap.set({ "n", "x" }, "<leader>rr", function()
			require("refactoring").select_refactor()
		end)
		-- You can also use below = true here to change the position of the printf
		-- statement (or set two rempas for either one). This rempa must be made in normal mode.
		keymap.set("n", "<leader>rp", function()
			require("refactoring").debug.printf({ below = false })
		end)
		-- Print var
		-- Supports both visual and normal node
		keymap.set({ "n", "x" }, "<leader>rv", function()
			require("refactoring").debug.print_var()
		end)

		-- Supports only normal mode
		keymap.set("n", "<leader>rc", function()
			require("refactoring").debug.cleanup({})
		end)
	end,
}
