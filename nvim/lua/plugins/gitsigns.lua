vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
	numhl = true,
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 0,
	},
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "<leader>gi", gs.preview_hunk, "Git preview hunk (inline)")
		map("n", "<leader>gd", function()
			gs.diffthis()
		end, "Git diff side-by-side")
		map("n", "<leader>gq", function()
			-- Close the diff (git side) window, keep the real file
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				local b = vim.api.nvim_win_get_buf(win)
				if vim.wo[win].diff and vim.bo[b].buftype ~= "" then
					vim.api.nvim_win_close(win, true)
				end
			end
			vim.cmd("diffoff")
		end, "Close git diff")

		map("n", "]c", function()
			gs.nav_hunk("next")
		end, "Next git hunk")
		map("n", "[c", function()
			gs.nav_hunk("prev")
		end, "Prev git hunk")
	end,
})
