return {
	{
		"stevearc/oil.nvim",
		opts = {
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		keys = {
			{ "<Leader>o", "<cmd>Oil<CR>", desc = "Oilで親ディレクトリを開く" },
		},
	},
}
