-- ラッパー関数
local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("i", "kj", "<Esc>", "挿入モードを抜ける")
map("i", "jj", "<Esc>", "挿入モードを抜ける")
map("n", "<ESC><ESC>", "<cmd>nohlsearch<CR>", "検索ハイライトを消す")
map("n", "<Leader>s", "<cmd>source $MYVIMRC<CR>", "設定ファイルを再読み込み")
map("n", "ZQ", "<nop>", "誤操作防止のために無効化（保存せずに閉じる）")
map("n", "Q", "@q", "qレジスタに入ったマクロを実行（exモードを無効化）")
map("n", "<C-w>-", "<cmd>split<CR>", "画面を水平に分割")
map("n", "<C-w>\\", "<cmd>vsplit<CR>", "画面を水平に分割")
