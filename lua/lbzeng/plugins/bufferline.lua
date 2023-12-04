return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "VeryLazy",

	keys = {
		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close non-pinned buffers" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
		{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
		{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },
		{ "<leader>bg", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
	},

	opts = {
		options = {
			mode = "buffer",
			numbers = "ordinal",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "left",
				},
			},
			diagnostics = "nvim_lsp",
			separator_style = "slant",
		},
	},
}
