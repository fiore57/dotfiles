return {
  {
    "stevearc/oil.nvim",
    opts = {
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
    keys = {
      { "<Leader>o", "<cmd>Oil<CR>", desc = "Oilで親ディレクトリを開く" },
    }

  }
}
