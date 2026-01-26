return {
        "stevearc/oil.nvim",
        lazy = false,
        keys = {
                { "-", "<cmd>Oil --float<cr>", desc = "Open parent directory" },
        },
        dependencies = {
                "refractalize/oil-git-status.nvim",
        },
        opts = {
                default_file_explorer = true,
                columns = { "icon" },
                win_options = {
                        signcolumn = "yes:2",
                },
                view_options = {
                        show_hidden = true,
                },
                keymaps = {
                        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
                        ["<Esc>"] = { callback = "actions.close", mode = "n" },
                        ["l"] = "actions.select",
                        ["h"] = "actions.parent",
                },
                float = {
                    padding = 4,
                    preview_split = "right",
                    border = "rounded",
                },
        },
        config = function(_, opts)
                require("oil").setup(opts)
                require("oil-git-status").setup({
                        show_ignored = false,
                })

                -- -- Open preview mode automatically when opening oil
                vim.api.nvim_create_autocmd("User", {
                        pattern = "OilEnter",
                        callback = vim.schedule_wrap(function(args)
                                local oil = require("oil")
                                if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
                                        oil.open_preview()
                                end
                        end),
                })
        end,
}
