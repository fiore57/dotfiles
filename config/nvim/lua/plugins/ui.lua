return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- 起動時に読み込む必要がある
    priority = 1000, -- 他のプラグインより先に読み込む
    init = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      }
    },
  }
}
