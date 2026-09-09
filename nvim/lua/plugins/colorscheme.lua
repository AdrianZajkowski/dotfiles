vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/rose-pine/neovim",
})

require("tokyonight").setup({
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})

require("rose-pine").setup({
	styles = {
		transparency = true,
	},
})

-- Zmien ponizsza linie, zeby przelaczyc motyw:
--   tokyonight  (tokyonight-night / -storm / -moon / -day)
--   rose-pine   (rose-pine-main / -moon / -dawn)
vim.cmd.colorscheme("tokyonight")

-- Jasniejszy divider (linia) pomiedzy splitami
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7aa2f7", bold = true })
