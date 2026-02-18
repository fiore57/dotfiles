return {
  {
    "saghen/blink.cmp",
    version = "*", -- 最新の安定版を使用
    event = { "InsertEnter", "CmdLineEnter" },
    opts = {
      -- キーマップ
      -- <C-Space>：補完開始
      -- <C-e>：隠す
      -- <CR>：決定
      -- <Up><Down>or<C-p><C-n>：候補選択
      -- <C-b><C-f>：ドキュメントをスクロール
      -- <C-k>：signature help window（関数呼び出し時に表示される情報）の表示/非表示を切り替え
      keymap = { preset = "enter" },
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
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  }
}
