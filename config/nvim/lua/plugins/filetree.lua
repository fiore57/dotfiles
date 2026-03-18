return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<Leader>n", ":Neotree toggle<CR>", desc = "ファイルツリーを開く" },
	},
	opts = {},
}
