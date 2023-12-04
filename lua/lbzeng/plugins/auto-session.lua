return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },

			-- fix corrupt auto-session with nvim-tree
			pre_save_cmds = { "NvimTreeClose" },
			save_extra_cmds = {
				"NvimTreeOpen",
			},
			post_restore_cmds = {
				"NvimTreeOpen",
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>sr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ss", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
	end,
}
