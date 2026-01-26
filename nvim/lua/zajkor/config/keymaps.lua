-- general
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open vim explorer" })
vim.g.mapleader = " "

-- Disable Space bar since it will be used as the leader key
vim.keymap.set({ "n", "v" }, "<leader>", "<nop>")

-- Save and quit current file quicker
vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = false, noremap = true })
vim.keymap.set({ "n", "t" }, "<leader>q", ":q<cr>", { silent = false, noremap = true })

-- Redo remap
vim.keymap.set("n", "U", "<C-r>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move this line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move this line down" })

-- Little one from Primeagen to mass replace string in a file
vim.keymap.set(
	"n",
	"<leader>rs",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ silent = false, desc = "Rename string in file" }
)

vim.keymap.set("n", "J", "mzJ`z", { desc = "Move below line to current line" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center view" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center view" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Find next and center view" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Find previous and center view" })
vim.keymap.set("n", "{", "{zzzv", { desc = "Find previous and center view" })
vim.keymap.set("n", "}", "}zzzv", { desc = "Find previous and center view" })
vim.keymap.set("n", "<S-A-j>", "yyp", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true, desc = "Clear search highlights" })

-- window management
vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

vim.keymap.set("n", "<leader>h", "<Cmd>wincmd h<CR>", { desc = "Move cursor to left window" })
vim.keymap.set("n", "<leader>j", "<Cmd>wincmd j<CR>", { desc = "Move cursor to bottomw window" })
vim.keymap.set("n", "<leader>k", "<Cmd>wincmd k<CR>", { desc = "Move cursor to top window" })
vim.keymap.set("n", "<leader>l", "<Cmd>wincmd l<CR>", { desc = "Move cursor to right window" })

-- buffers
vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Go to previous buffer", noremap = true, silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Go to previous buffer", noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>bc", "<Cmd>bdelete<CR>", { desc= "Buffer close" })
-- vim.keymap.set("n", "<leader>bb", "<Cmd>%bd|e#|bd#<CR>", { desc = "Buffer close all without current" })

-- Exit terminal with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>")

-- remaps to copy paste delete without buffer
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set("n", "x", '"_x')

-- golang
vim.keymap.set("n", "<leader>err", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "Golang error snippet" })

-- toggle inline hint
vim.keymap.set("n", "<leader>i", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay Hints Enabled" or "Inlay Hints Disabled")
end)

-- go to split
local splitnav = require("zajkor.config.splitnav")
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		splitnav.goto_split(i)
	end, { desc = "Go to split " .. i })
end
