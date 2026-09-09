-- LSP configuration for the Go language server (gopls).
--
-- Neovim 0.11+ uses `vim.lsp.enable()` which automatically picks up files
-- inside the `lsp/` folder. This file is returned as a Lua table and Neovim
-- passes it straight to the LSP client.
--
-- Requirements: gopls must be on your $PATH.
--   go install golang.org/x/tools/gopls@latest

return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			vulncheck = "Imports",
			analyses = {
				unusedparams = true,
				unusedwrite = true,
			},
			codelenses = {
				generate = true,
				gc_details = true,
				tidy = true,
				test = true,
				vendor = true,
				upgrade_dependency = true,
				regenerate_cgo = true,
				run_govulncheck = true,
			},
		},
	},
}
