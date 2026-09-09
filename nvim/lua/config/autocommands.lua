-- Highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.hl.on_yank({ timeout = 200, visual = true })
	end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- Auto resize splits when the terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- Syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- Show cursorline only in the active window
local cursorline_group = vim.api.nvim_create_augroup("active_cursorline", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = cursorline_group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- Show folder name in Ghostty tab title
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
	vim.o.title = true
	vim.o.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

-- Open oil on startup when no file arguments are passed
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("oil_auto_open", { clear = true }),
	nested = true,
	callback = function()
		if vim.fn.argc() == 0 then
			vim.schedule(function()
				require("oil").open(vim.fn.getcwd())
			end)
		end
	end,
})

