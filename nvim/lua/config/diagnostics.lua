vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics<cr>", { silent = true, desc = "Diagnostics (Telescope)" })

for _, name in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	vim.api.nvim_set_hl(0, "DiagnosticUnderline" .. name, {
		undercurl = true,
		sp = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. name }).fg,
	})
end

local function refresh_diagnostics_qf()
	local qf = vim.fn.getqflist({ title = 0, winid = 0 })
	local title = qf.title or ""
	if qf.winid ~= 0 and (title:lower():find("diagnostic") or title == "") then
		vim.diagnostic.setqflist({ open = false })
	end
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	desc = "Auto-refresh quickfix list with diagnostics",
	callback = function()
		vim.schedule(refresh_diagnostics_qf)
	end,
})

vim.keymap.set("n", "<leader>xr", function()
	vim.diagnostic.setqflist({ open = false })
end, { desc = "Refresh diagnostics quickfix" })
