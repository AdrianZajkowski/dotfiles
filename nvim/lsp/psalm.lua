-- LSP configuration for Psalm (PHP static analysis tool).
--
-- Neovim 0.11+ uses `vim.lsp.enable()` which automatically picks up files
-- inside the `lsp/` folder. This file is returned as a Lua table and Neovim
-- passes it straight to the LSP client.
--
-- Psalm runs alongside Phpactor purely for diagnostics (type-checking).
-- Completion/hover/definition capabilities are stripped so it doesn't
-- duplicate what Phpactor already provides.
--
-- Requirements: psalm must be on your $PATH (brew install psalm), and the
-- project must have a psalm.xml / psalm.xml.dist config file
-- (composer require --dev vimeo/psalm && vendor/bin/psalm --init).

return {
	cmd = { "psalm", "--language-server" },
	filetypes = { "php" },
	root_markers = { "psalm.xml", "psalm.xml.dist" },
	on_init = function(client)
		client.server_capabilities.completionProvider = nil
		client.server_capabilities.hoverProvider = nil
		client.server_capabilities.definitionProvider = nil
		client.server_capabilities.documentSymbolProvider = nil
		client.server_capabilities.codeActionProvider = nil
	end,
}
