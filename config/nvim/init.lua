---
--- 基本設定
---

local opt = vim.opt

opt.swapfile = false -- スワップファイルを作らない
opt.undofile = true -- neovimを一度閉じても、uで戻せる

opt.scrolloff = 5 -- スクロール時に上下に余白を確保する

--[[
yankやdeleteなどを行うと、通常その文字列は無名レジスタに入る
その文字列を+レジスタ（クリップボード）にも入れる設定
これにより、WSL側でヤンク（y）した文字列をWindows側で貼り付け（<C-v>）できるようになる
なお、この設定だけではWindows側でコピー（<C-c>）した文字列をWSL側でプット（p）することはできない
]]
opt.clipboard = "unnamedplus"

opt.virtualedit = "block" -- 矩形選択で自由に移動できるようにする

opt.number = true -- 行番号を表示
opt.relativenumber = true -- 行番号の相対表示（現在の行だけ絶対表示）
opt.cursorline = true -- 現在の行を強調表示
opt.termguicolors = true -- 24bit RGBカラーを有効にする

opt.laststatus = 3 -- ステータスラインを最下部のみに表示（画面を分割しても1つだけ表示）

opt.list = true -- タブや余計な空白などの不可視文字を可視化する
opt.listchars = { tab = "> ", nbsp = "+", trail = "·" }

opt.expandtab = true -- タブをスペースに置き換える
opt.tabstop = 2 -- タブ文字の見た目上の幅
opt.shiftwidth = 2 -- インデントの見た目上の幅

opt.ignorecase = true -- 検索で大文字・小文字を区別しない
opt.smartcase = true -- 検索で大文字を含んでいたら、大文字・小文字を区別する
opt.hlsearch = true -- 検索結果をハイライト

opt.updatetime = 250 -- ここで指定した時間ユーザーが操作しなかったとき、CursorHoldイベントが呼び出される
opt.pumblend = 10 -- 補完などのポップアップメニューの透明度
opt.winblend = 10 -- プラグインが表示するフローティングウィンドウの透明度

---
--- キーマップ
---

vim.g.mapleader = " " -- <Leader>をスペースキーに割り当てる

local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("i", "kj", "<Esc>", "挿入モードを抜ける")
map("i", "jj", "<Esc>", "挿入モードを抜ける")
map("n", "<ESC><ESC>", "<cmd>nohlsearch<CR>", "検索ハイライトを消す")
map("n", "<Leader>s", "<cmd>source $MYVIMRC<CR>", "設定ファイルを再読み込み")
map("n", "ZQ", "<nop>", "誤操作防止のために無効化（保存せずに閉じる）")
map("n", "Q", "<nop>", "誤操作防止のために無効化（exモード）")
map("n", "<C-w>-", "<cmd>split<CR>", "画面を水平に分割")
map("n", "<C-w>\\", "<cmd>vsplit<CR>", "画面を水平に分割")

---
--- 自動コマンド
---

-- ファイルを開いた時に、前回閉じた位置にカーソルを移動させる
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    -- mark '" は、前回閉じた時の「行」と「列」の両方の情報を持っている
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    -- 行番号が有効な範囲内（1行目から最終行の間）にあるかチェック
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ヤンクした部分を一瞬だけ光らせる
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

---
--- プラグイン
---

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- lua/plugins/ ディレクトリ内のファイルを全て読み込む
    { import = "plugins" },
  },
  checker = { enabled = true },
})

