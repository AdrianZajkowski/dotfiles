return {
	"akinsho/bufferline.nvim",
	lazy = false,
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				separator_style = { "", "" },
				diagnostics = "nvim_lsp",
				show_close_icon = false,
				style_preset = {
					bufferline.style_preset.no_italic,
					bufferline.style_preset.no_bold,
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						text = function()
							local cwd = vim.fn.getcwd()
							return vim.fn.fnamemodify(cwd, ":t")
						end,
						filetype = "NvimTree",
						highlight = "Normal",
						text_align = "left",
					},
				},
			},
			highlights = {
				fill = {
					-- bg = "#303446",
				},
			},
		})
	end,
}
