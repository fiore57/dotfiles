return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} }, -- setup()のためにopts = {}とする
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				-- デフォルトでautomatic_enable = true
				-- vim.lsp.enable()は不要
				"lua_ls",
				"stylua",
				"taplo",
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			vim.lsp.enable("hls") -- ghcup管理であるため、必要
			vim.lsp.enable("rust_analyzer")
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<Leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnosticsを表示(Trouble)",
			},
			{
				"<Leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "現在のバッファのDiagnosticsを表示(Trouble)",
			},
			{
				"<Leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "LSPドキュメントシンボル一覧を表示 (Trouble)",
			},
			{
				"<Leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP定義・参照などを表示(Trouble)",
			},
			{
				"<Leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
			{
				"<Leader>xt",
				"<cmd>Trouble telescope toggle<cr>",
				desc = "TelescopeのTrubleを開閉(Trouble)",
			},
			{
				"]t",
				function()
					require("trouble").next({ skip_groups = true, jump = true })
				end,
				desc = "Next trouble item",
			},
			{
				"[t",
				function()
					require("trouble").prev({ skip_groups = true, jump = true })
				end,
				desc = "Prev trouble item",
			},
		},
	},
}
