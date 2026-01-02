return {
  {
    "saghen/blink.cmp",
    version = "*", -- 最新の安定版を使用
    event = "InsertEnter",
    opts = {
      -- キーマップ
      -- デフォルト場合、C-Spaceで補完開始、Enterで決定、上下で候補選択
      keymap = { preset = "default" },
      -- 補完ソース
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      -- 見た目
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
      },
      -- 補完ウィンドウの見た目
      completion = {
        menu = {
          border = "rounded",
          winblend = 0,
        },
        documentation = {
          auto_show = true,
          window = { border = "rounded" },
        },
      },
    },
  },
}
