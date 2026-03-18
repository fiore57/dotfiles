return {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	-- どのファイルがあったらプロジェクトとみなすか
	root_markers = { "cabal.project", "stack.yaml", "package.yaml", ".git" },
	settings = {
		haskell = {
			formattingProvider = "ormolu",
		},
	},
}
