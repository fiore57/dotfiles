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
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" },
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
		"nvim-mini/mini.clue",
		opts = function()
			local miniclue = require("mini.clue")
			return {
				triggers = {
					-- square_brackets
					{ mode = "n", keys = "[" },
					{ mode = "n", keys = "]" },
					-- Built-in completion
					{ mode = { "i" }, keys = "<C-x>" },
					-- g
					{ mode = { "n", "x" }, keys = "g" },
					-- marks
					{ mode = { "n", "x" }, keys = "'" },
					{ mode = { "n", "x" }, keys = "`" },
					-- registers
					{ mode = { "n", "x" }, keys = '"' },
					-- windows
					{ mode = "n", keys = "<C-w>" },
					-- z
					{ mode = { "n", "x" }, keys = "z" },
					-- leader
					{ mode = { "n", "x" }, keys = "<Leader>" },
					-- mini.surround
					{ mode = { "n", "x" }, keys = "s" },
				},
				clues = {
					miniclue.gen_clues.square_brackets(),
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers({ show_contents = true }),
					miniclue.gen_clues.windows({ submode_resize = true, submode_move = true }),
					miniclue.gen_clues.z(),
				},
			}
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
