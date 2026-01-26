# AGENTS.md - Guide for AI Coding Agents

This file contains guidelines for AI agents working on this personal Neovim configuration.

## Project Overview

- **Type**: Personal Neovim configuration (NOT a standard software project)
- **Language**: Lua
- **Namespace**: `zajkor.*` - all custom code lives under this namespace
- **Plugin Manager**: Lazy.nvim with auto-import
- **Target Languages**: Go, TypeScript/JavaScript, PHP, Lua
- **Structure**: Modular plugin-based architecture

## Directory Structure

```
~/.config/nvim/
├── init.lua                        # Entry point: requires config and lazy
├── lazy-lock.json                  # Plugin version lockfile (commit hashes)
├── lua/zajkor/
│   ├── lazy.lua                    # Lazy.nvim bootstrap
│   ├── config/
│   │   ├── init.lua                # Loads options and keymaps
│   │   ├── options.lua             # Vim options + autocommands
│   │   ├── keymaps.lua             # Global keybindings
│   │   └── splitnav.lua            # Custom split navigation module
│   └── plugins/
│       ├── init.lua                # Empty - uses auto-import
│       ├── [plugin-name].lua       # Each plugin gets own file
│       ├── lsp.lua                 # LSP configuration
│       ├── formatting.lua          # Code formatting setup
│       ├── testing.lua             # Neotest configuration
│       └── debugging.lua           # DAP configuration
└── lsp/
    ├── lua_ls.lua                  # Lua language server config
    ├── ts_ls.lua                   # TypeScript language server config
    └── gopls.lua                   # Go language server config
```

**Key principle**: Lazy.nvim auto-imports all files from `lua/zajkor/plugins/` directory.

## No Build/Test/Lint Commands

**IMPORTANT**: This is a Neovim configuration, NOT a project with traditional CI/CD.

- **No build system**: No Makefile, no package.json scripts, no build commands
- **No CLI tests**: Testing happens INSIDE Neovim via Neotest (see Workflow section)
- **No standalone linter**: Linting via LSP diagnostics only (eslint runs as LSP)
- **Formatting**: Automatic on-save via conform.nvim

**When asked to "run tests"**: Use Neotest keybindings inside Neovim, not CLI commands.

## Code Style Guidelines

### Naming Conventions

- **Files**: `lowercase-with-hyphens.lua` (e.g., `which-key.lua`, `splitnav.lua`)
- **Functions**: `snake_case()` (e.g., `goto_split()`, `is_floating()`)
- **Local variables**: `camelCase` (e.g., `local splitnav`, `local telescope`)
- **Namespace**: Always `zajkor.*` for custom modules
- **LSP configs**: Match server name exactly (e.g., `lua_ls.lua`, `ts_ls.lua`)

### Formatting

- **Indentation**: 4 spaces (no tabs)
- **Comments**: `-- ` (double dash with space)
- **String quotes**: Double quotes `"string"` preferred
- **Line length**: No strict limit, but be reasonable

### Import/Require Patterns

```lua
-- At top of config files
require("zajkor.config")
require("zajkor.lazy")

-- Inside functions (lazy-loaded)
local telescope = require("telescope")
local actions = require("telescope.actions")

-- Plugin auto-import (in lazy.lua)
spec = {
    { import = "zajkor.plugins" }  -- Auto-imports all plugin files
}
```

### Plugin Structure Pattern

**Every plugin file** in `lua/zajkor/plugins/` should return a Lazy.nvim spec:

```lua
return {
    "author/plugin-name",
    dependencies = {
        "dependency/plugin",
    },
    opts = {
        -- Simple config goes here
    },
    -- OR for complex setup:
    config = function()
        require("plugin").setup({
            -- config here
        })
    end,
    -- Lazy-loaded keymaps:
    keys = {
        { "<leader>x", "<cmd>Command<cr>", desc = "Description" },
    },
}
```

**Pattern notes**:
- Use `opts = {}` for simple configs (Lazy calls `.setup()` automatically)
- Use `config = function()` for complex initialization
- Always provide `desc` for keymaps (integrates with which-key)
- Lazy-load when possible using `keys`, `cmd`, `ft`, or `event`

### Keymap Pattern

**ALWAYS include `desc` for which-key integration**:

```lua
vim.keymap.set("n", "<leader>xy", function_or_command, {
    desc = "Human-readable description",  -- REQUIRED
    silent = true,
    noremap = true,
})
```

**Leader key**: `<space>`

**Organization by prefix**:
- `<leader>f` = find (Telescope)
- `<leader>t` = test (Neotest)
- `<leader>d` = debug (DAP)
- `<leader>g` = git
- `<leader>r` = rename/replace

### Autocommand Pattern

**Always use augroups to prevent duplicates**:

```lua
local augroup = vim.api.nvim_create_augroup("GroupName", { clear = true })

vim.api.nvim_create_autocmd("EventName", {
    group = augroup,
    pattern = "*.ext",
    callback = function()
        -- code here
    end,
})
```

### Error Handling Pattern

**Check return values from system calls**:

```lua
local result = vim.fn.systemlist("command")[1]
if result == nil or result == "" then
    vim.notify("Error message", vim.log.levels.WARN)
    return
end
```

**Bootstrap errors** (like in lazy.lua):

```lua
if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
        { "Failed: ", "ErrorMsg" },
        { error_output, "WarningMsg" },
    }, true, {})
    os.exit(1)
end
```

## Adding New Features

### Adding a New Plugin

1. Create new file: `lua/zajkor/plugins/plugin-name.lua`
2. Return Lazy.nvim spec (see pattern above)
3. Auto-import works automatically (no need to require manually)
4. Run `:Lazy sync` inside Neovim to install

### Adding Support for a New Language

**Complete checklist**:

1. **LSP Server**: Add to `lua/zajkor/plugins/mason.lua` in `ensure_installed`
2. **LSP Config**: Create `lsp/server_name.lua` with server-specific settings
3. **Enable LSP**: Add to `lua/zajkor/plugins/lsp.lua` in `vim.lsp.enable()` call
4. **Formatter**: Add to `lua/zajkor/plugins/formatting.lua` in `formatters_by_ft`
5. **Treesitter**: Add to `lua/zajkor/plugins/treesitter.lua` in `ensure_installed`
6. **Test Adapter** (if needed): Add to `lua/zajkor/plugins/testing.lua` adapters

**Example** (adding Python support):

```lua
-- 1. In mason.lua
ensure_installed = {
    "pyright",  -- Add Python LSP
}

-- 2. Create lsp/pyright.lua
return {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
            },
        },
    },
}

-- 3. In lsp.lua
vim.lsp.enable({ "lua_ls", "ts_ls", "gopls", "pyright" })

-- 4. In formatting.lua
formatters_by_ft = {
    python = { "black" },
}

-- 5. In treesitter.lua
ensure_installed = {
    "python",
}
```

### Adding New Keybindings

**Plugin-specific keybindings**: Add to plugin file using `keys = {}`

```lua
-- In lua/zajkor/plugins/telescope.lua
keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
}
```

**Global keybindings**: Add to `lua/zajkor/config/keymaps.lua`

```lua
vim.keymap.set("n", "<leader>xy", "<cmd>Command<cr>", {
    desc = "Description for which-key",  -- REQUIRED
    silent = true,
})
```

### Modifying Existing Configuration

1. **Find the file**: Check `lua/zajkor/plugins/` for plugin configs
2. **Edit in place**: Modify the existing spec/config
3. **Reload**: Run `:Lazy reload plugin-name` or restart Neovim

## Tools and Workflow

### Testing (Neotest)

**No CLI test commands** - everything runs inside Neovim:

```
<leader>tt     # Run tests in current file
<leader>tr     # Run nearest test (under cursor)
<leader>tT     # Run all tests in project
<leader>tl     # Run last test
<leader>ts     # Toggle summary window
<leader>to     # Show output
<leader>tw     # Toggle watch mode
<leader>tS     # Stop running tests
```

**Supported frameworks**: Go (with DAP), PHP (PHPUnit), Vim, Lua (Plenary)

### Formatting

- **Auto-format on save**: Enabled for all configured file types (500ms timeout)
- **Formatters by language**:
  - Lua: `stylua`
  - JavaScript/TypeScript/React: `prettierd`
  - CSS/HTML/YAML/JSON/Markdown: `prettier`
  - PHP: `php_cs_fixer`
  - Go: `goimports` + `gofmt`

**No manual format command needed** - saves trigger format automatically.

### LSP

**Configured servers**: lua_ls, ts_ls, gopls, eslint, phpactor, vacuum

**Key bindings**:
```
gd             # Go to definition (Telescope)
gr             # Go to references (Telescope)
gi             # Go to implementations (Telescope)
K              # Hover documentation
<leader>rn     # Rename symbol
<leader>.      # Code actions
<leader>k      # Show diagnostic
```

**Diagnostic icons**: ERROR: " ", WARN: " ", HINT: "󰠠 ", INFO: " "

### Debugging (DAP)

**Only configured for Go** with 8 pre-configured microservices:

```
<leader>dt     # Toggle DAP UI
<leader>db     # Toggle breakpoint
<leader>dc     # Continue/Start
<leader>dw     # Watch variable
```

**Pre-configured services** (remote attach on ports 2345-2352):
- router-api (2345), vault-api (2346), risk-api (2347), fraud-api (2348)
- cardbin-api (2349), account-api (2350), three-ds-api (2351), schedule-api (2352)

### File Navigation

```
<leader>ff     # Find files (Telescope)
<leader>fg     # Live grep (search in files)
<leader>fb     # Open buffers
<leader>fr     # Recent files
<leader>fs     # Search current word
-              # Open Oil (file browser)
```

## Special Features

### Split Navigation by Number

Custom module `lua/zajkor/config/splitnav.lua` allows jumping to splits:

```
<leader>1      # Jump to first split
<leader>2      # Jump to second split
...
<leader>9      # Jump to ninth split
```

Filters out floating windows and sorts by position.

### Workspace-Wide Diagnostics

TypeScript LSP configured for entire git repository diagnostics (excludes node_modules, dist).

### PHP Testing Memory Override

PHPUnit runs with unlimited memory: `php -d memory_limit=-1 vendor/bin/phpunit`

## Common Patterns to Follow

When adding new functionality, always:

1. **Check existing patterns**: Look at similar plugin configs first
2. **Use the namespace**: Custom modules go in `zajkor.*`
3. **One file per plugin**: Don't combine multiple plugins in one file
4. **Include descriptions**: All keymaps need `desc` for which-key
5. **Error handling**: Check return values, provide user feedback with `vim.notify()`
6. **Lazy-load when possible**: Use `keys`, `cmd`, `ft`, or `event` in plugin specs
7. **Follow naming conventions**: Files lowercase-with-hyphens, functions snake_case
8. **Document complex logic**: Add comments explaining "why", not "what"

