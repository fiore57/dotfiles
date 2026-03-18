return {
	{
		"nvim-mini/mini.surround",
		version = false,
		event = "VeryLazy",
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				haskell = { "ormolu" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
