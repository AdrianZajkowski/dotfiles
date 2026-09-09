vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/refractalize/oil-git-status.nvim",
})

require("oil").setup({
	default_file_explorer = true,
	columns = { "icon" },
	win_options = {
		signcolumn = "yes:2",
		foldenable = false,
		foldmethod = "manual",
	},
	preview_win = {
		preview_method = "fast_scratch",
	},
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["<C-v>"] = { "actions.select", opts = { vertical = true } },
		["<Esc>"] = { callback = "actions.close", mode = "n" },
		["l"] = "actions.select",
		["h"] = "actions.parent",
	},
	float = {
		padding = 4,
		preview_split = "right",
		border = "rounded",
	},
})

require("oil-git-status").setup({
	show_ignored = false,
})

-- Open preview automatically whenever an oil buffer is entered
-- (works for both the float via "-" and the fullscreen auto-open on startup).
vim.api.nvim_create_autocmd("User", {
	pattern = "OilEnter",
	callback = vim.schedule_wrap(function(args)
		local oil = require("oil")
		if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
			oil.open_preview()
		end
	end),
})

vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open parent directory" })
