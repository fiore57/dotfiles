return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-t>", [[<cmd>ToggleTerm<CR>]], mode = "n", desc = "Toggle Terminal" },
      { "<Leader>t-", [[<cmd>ToggleTerm direction=horizontal<CR>]], mode = "n", desc = "Horizontal Terminal" },
      { "<Leader>t\\", [[<cmd>ToggleTerm direction=vertical<CR>]], mode = "n", desc = "Vertical Terminal" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.3)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      start_in_insert = true,
      direction = "float",
      insert_mappings = false,
      terminal_mappings = true,
      close_on_exit = true,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 3,
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.85)
        end,
      },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      -- ターミナル専用キーマップ
      local function set_terminal_keymaps()
        local b_opts = { buffer = 0, noremap = true, silent = true }
        -- ターミナルモードでも <C-t> で閉じる
        vim.keymap.set("t", "<C-t>", [[<cmd>ToggleTerm<CR>]], b_opts)
        -- ESC でノーマルモードへ
        vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], b_opts)
        -- ウィンドウ移動
        vim.keymap.set("t", "<C-h>", [[<cmd>wincmd h<CR>]], b_opts)
        vim.keymap.set("t", "<C-j>", [[<cmd>wincmd j<CR>]], b_opts)
        vim.keymap.set("t", "<C-k>", [[<cmd>wincmd k<CR>]], b_opts)
        vim.keymap.set("t", "<C-l>", [[<cmd>wincmd l<CR>]], b_opts)
      end
      local group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = set_terminal_keymaps,
        group = group,
        desc = "Setup toggleterm keymaps",
      })
    end,
  },
}
