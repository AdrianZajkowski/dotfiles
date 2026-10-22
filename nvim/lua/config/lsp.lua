-- lsp
vim.lsp.enable({ "lua_ls", "tsgo", "gopls", "phpactor", "psalm", "vacuum" })

local severity = vim.diagnostic.severity
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	signs = {
		text = {
			[severity.ERROR] = "󰅚 ",
			[severity.WARN] = "󰀪 ",
			[severity.HINT] = "󰋽 ",
			[severity.INFO] = "󰌶 ",
		},
	},
	virtual_lines = {
		current_line = true,
		update_in_insert = true,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		local opts = { buffer = ev.buf, silent = true }
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
		vim.keymap.set("n", "gr", builtin.lsp_references, opts)
		vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts)

		if client ~= nil and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end

		if client ~= nil and client:supports_method("textDocument/codeLens") then
			vim.lsp.codelens.refresh({ bufnr = ev.buf })
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				buffer = ev.buf,
				callback = function()
					vim.lsp.codelens.refresh({ bufnr = ev.buf })
				end,
			})
			vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, { buffer = ev.buf, desc = "Run CodeLens" })
		end
	end,
})
