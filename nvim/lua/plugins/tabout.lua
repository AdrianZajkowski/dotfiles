vim.pack.add({
	"https://github.com/abecodes/tabout.nvim",
})

require("tabout").setup({
	tabkey = "<Tab>",
	backwards_tabkey = "<S-Tab>",
	act_as_tab = true,
	act_as_shift_tab = false,
	enable_backwards = true,
	completion = false,
	ignore_beginning = true,
})
