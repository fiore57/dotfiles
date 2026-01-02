return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<Leader>ff", "<cmd>Telescope find_files<CR>", desc = "ファイルを検索" },
    { "<Leader>fg", "<cmd>Telescope live_grep<CR>", desc = "ファイル内検索" },
    { "<Leader>fb", "<cmd>Telescope buffers<CR>", desc = "バッファ検索" },
    { "<Leader>fh", "<cmd>Telescope help_tags<CR>", desc = "ヘルプ検索" },

  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
  opts = {
    defaults = {
      sorting_strategy = "ascending",               -- 検索結果を上から順に並べる
      layout_config = { prompt_position = "top" },  -- 上に検索窓を置く
      winblend = 0,                                 -- 背景を透明に
    }
  },
}
