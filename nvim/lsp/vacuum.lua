-- LSP configuration for vacuum (OpenAPI linter).
--
-- Neovim 0.11+ uses `vim.lsp.enable()` which automatically picks up files
-- inside the `lsp/` folder. This file is returned as a Lua table and Neovim
-- passes it straight to the LSP client.
--
-- Since OpenAPI specs are plain YAML/JSON files, we can't rely on filetype
-- alone. `root_dir` is used here as a detector: it only activates the
-- client when the buffer looks like an OpenAPI/Swagger document (by
-- filename or by an `openapi:`/`swagger:` key near the top of the file).
--
-- Requirements: vacuum must be on your $PATH.
--   brew install daveshanley/vacuum/vacuum

local function is_openapi_file(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr):lower()
	if name:match("openapi") or name:match("swagger") then
		return true
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 50, false)
	for _, line in ipairs(lines) do
		if line:match("^openapi%s*:") or line:match("^swagger%s*:") or line:match('"openapi"%s*:') or line:match('"swagger"%s*:') then
			return true
		end
	end

	return false
end

return {
	cmd = { "vacuum", "language-server" },
	filetypes = { "yaml", "json" },
	root_dir = function(bufnr, on_dir)
		if not is_openapi_file(bufnr) then
			return
		end
		on_dir(vim.fs.root(bufnr, { ".git" }) or vim.fn.getcwd())
	end,
}
