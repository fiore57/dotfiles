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
