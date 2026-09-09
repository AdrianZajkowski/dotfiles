vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local d = ev.data
		if d.spec and d.spec.name == "telescope-fzf-native.nvim" and (d.kind == "install" or d.kind == "update") then
			vim.system({ "make" }, { cwd = d.path })
		end
	end,
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["l"] = actions.select_default,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		git_files = {
			show_untracked = true,
		},
	},
	extensions = {
		["ui-select"] = {
			themes.get_dropdown({}),
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr><esc>", { desc = "Telescope recent files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope help tags" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers" })
map("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Telescope git changed files" })
