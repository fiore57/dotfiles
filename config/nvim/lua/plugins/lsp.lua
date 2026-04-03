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
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			vim.lsp.enable("hls") -- ghcup管理であるため、必要
			vim.lsp.enable("rust_analyzer")
		end,
	},
}
