local M = {}

-- User-configurable: filetype -> shell command (stdin/stdout)
M.formatters = {
	lua = "stylua -",
	javascript = "prettier --stdin-filepath %",
	typescript = "prettier --stdin-filepath %",
	typescriptreact = "prettier --stdin-filepath %",
	json = "prettier --stdin-filepath %",
	go = "gofmt",
}

-- Run gopls "organize imports" (goimports) before saving Go files.
local function organize_go_imports(bufnr)
	local params = vim.lsp.util.make_range_params(0, "utf-8")
	params.context = { only = { "source.organizeImports" } }
	local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
	for _, res in pairs(results or {}) do
		for _, action in pairs(res.result or {}) do
			if action.edit then
				vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
			elseif type(action.command) == "table" then
				vim.lsp.buf.execute_command(action.command)
			end
		end
	end
end

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		local bufnr = args.buf
		local ft = vim.bo[bufnr].filetype
		local cmd = M.formatters[ft]

		if ft == "go" then
			organize_go_imports(bufnr)
		end

		if cmd then
			-- Replace % with actual buffer path for tools that need it
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local resolved = cmd:gsub("%%", bufname)

			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local input = table.concat(lines, "\n")

			local output = vim.fn.system(resolved, input)

			if vim.v.shell_error == 0 then
				local formatted = vim.split(output, "\n", { plain = true })
				-- Remove trailing empty line that shell commands often append
				if formatted[#formatted] == "" then
					table.remove(formatted)
				end
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
			end
		else
			-- No external formatter: try LSP
			for _, cl in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
				if cl:supports_method("textDocument/formatting") then
					vim.lsp.buf.format({ bufnr = bufnr, async = false })
					break
				end
			end
		end
	end,
})

return M
