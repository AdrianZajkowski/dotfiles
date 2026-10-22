-- LSP configuration for Phpactor (PHP language server).
--
-- Neovim 0.11+ uses `vim.lsp.enable()` which automatically picks up files
-- inside the `lsp/` folder. This file is returned as a Lua table and Neovim
-- passes it straight to the LSP client.
--
-- Free features include: completion, navigation, rename, go to implementation,
-- code actions, generate method/class, extract method, PHPStan integration,
-- and Symfony integration (service/route/twig lookups).
--
-- Requirements: phpactor must be on your $PATH.
--   curl -Lo phpactor.phar https://github.com/phpactor/phpactor/releases/latest/download/phpactor.phar
--   chmod a+x phpactor.phar
--   mv phpactor.phar ~/.local/bin/phpactor

return {
	cmd = { "phpactor", "language-server" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".phpactor.json", ".git" },
}
