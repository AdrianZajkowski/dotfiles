-- Disable Space since it's the leader key
vim.keymap.set({ "n", "v" }, "<leader>", "<nop>")

-- Write and quit
vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true })
vim.keymap.set("n", "<leader>q", ":q<cr>", { silent = true })

-- Redo
vim.keymap.set("n", "U", "<c-r>", { silent = true })

-- Swap between split buffers
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", { silent = true, desc = "Move to right split" })

-- Move selected lines up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered on scroll and search
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line, keep cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match, centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev match, centered" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true, desc = "Clear search highlights" })

-- Rename word under cursor in file
vim.keymap.set(
	"n",
	"<leader>rs",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Rename word in file" }
)

-- Registers: paste/yank/delete without clobbering the unnamed register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yank" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without yank" })

-- Buffers
vim.keymap.set("n", "H", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "L", ":bnext<CR>", { silent = true, desc = "Next buffer" })

-- Splits
vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>V", "<C-w>h", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { desc = "Exit terminal mode" })

-- Golang error snippet
vim.keymap.set("n", "<leader>err", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "Go error snippet" })

-- Toggle inlay hints
vim.keymap.set("n", "<leader>i", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

-- Jump to split by number
local splitnav = require("config.splitnav")
for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		splitnav.goto_split(i)
	end, { desc = "Go to split " .. i })
end
