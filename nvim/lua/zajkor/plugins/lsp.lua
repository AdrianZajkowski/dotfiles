return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"rachartier/tiny-code-action.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.lsp.enable({ "lua_ls", "ts_ls", "gopls", "eslint", "psalm", "phpactor", "vacuum" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }

				vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
				vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
				vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
				vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				vim.keymap.set({ "n", "x" }, "<leader>.", function()
					require("tiny-code-action").code_action()
				end, { noremap = true, silent = true })

				vim.keymap.set("n", "<leader>k", function()
					vim.diagnostic.open_float({
						border = "rounded",
					})
				end, opts)
			end,
		})

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
				-- linehl = {
				-- 	[vim.diagnostic.severity.ERROR] = "DiagnosticLineError",
				-- 	[vim.diagnostic.severity.WARN] = "DiagnosticLineWarn",
				-- 	[vim.diagnostic.severity.INFO] = "DiagnosticLineInfo",
				-- 	[vim.diagnostic.severity.HINT] = "DiagnosticLineHint",
				-- },
			},
			virtual_lines = {
				current_line = true,
				update_in_insert = true,
			},
		})
	end,
}
