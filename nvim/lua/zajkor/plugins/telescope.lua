return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
		{ "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr><esc>", desc = "Telescope find recent files" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
		{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Telescope find by current word (grep string)" },
		{
			"<leader>fS",
			"<cmd>Telescope grep_string<cr>",
			desc = "Telescope find by current extended Word (grep string)",
		},
	},
	config = function()
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
		require("telescope").load_extension("ui-select")
	end,
}
