-- autocmd group（関連するautocmdをグループ化して管理しやすくする）
local augroup = vim.api.nvim_create_augroup("autocmds.lua", {}) -- デフォルトでclear = true

-- ラッパー関数
local function create_autocmd(event, opts)
	vim.api.nvim_create_autocmd(
		event,
		vim.tbl_extend("force", {
			group = augroup,
		}, opts)
	)
end

create_autocmd("BufReadPost", {
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
	desc = "ファイルを開いた時に、前回閉じた位置にカーソルを移動させる",
})

create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 500 })
	end,
	desc = "ヤンクした部分を光らせる",
})

create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
	desc = "カーソルを合わせたら診断（Diagnostic）を表示",
})
create_autocmd("LspAttach", {
	pattern = "*",
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }
		vim.keymap.set(
			"n",
			"gd",
			vim.lsp.buf.definition,
			vim.tbl_extend("force", opts, { desc = "定義ジャンプ" })
		)
		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			vim.tbl_extend("force", opts, { desc = "宣言ジャンプ" })
		)
	end,
	desc = "LSP用キーバインドを設定",
})
