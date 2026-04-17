return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- 起動時に読み込む必要がある
		priority = 1000, -- 他のプラグインより先に読み込む
		init = function()
			vim.cmd.colorscheme("tokyonight-storm")
		end,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
				globalstatus = true,
			},
		},
	},
	{
		"vim-jp/vimdoc-ja",
		config = function()
			vim.opt.helplang = "ja,en"
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<Leader>gg", "<cmd>Neogit<CR>", { desc = "Show Neogit UI" } },
		},
	},
}
