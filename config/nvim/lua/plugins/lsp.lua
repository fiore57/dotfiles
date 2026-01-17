return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })
      vim.lsp.enable("lua_ls")
      vim.lsp.config["hls"] = {
        install = {
          cmd = { "haskell-language-server-wrapper", "--lsp" },
        },
        -- どのファイルがあったらプロジェクトとみなすか
        root_markers =  { "cabal.project", "stack.yaml", "package.yaml", ".git" },
        settings = {
          haskell = {
            formattingProvider = "ormolu",
          }
        }
      }
      vim.lsp.enable("hls")
    end,
  }
}
