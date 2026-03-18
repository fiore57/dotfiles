local opt = vim.opt

vim.g.mapleader = " " -- <Leader>をスペースキーに割り当てる

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

vim.diagnostic.config({
	virtual_text = true, -- 行末にエラーメッセージを表示
	severity_sort = true, -- 重大なエラーを優先表示
})
