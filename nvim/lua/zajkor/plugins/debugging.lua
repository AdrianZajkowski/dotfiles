return {
	"igorlfs/nvim-dap-view",
	dependencies = {
		"mfussenegger/nvim-dap",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
	},
	keys = {
		{ "<leader>dt", "<cmd>DapViewToggle<cr>" },
		{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>" },
		{ "<leader>dc", "<cmd>DapContinue<cr>" },
		{ "<leader>dw", "<cmd>DapViewWatch<cr>" },
	},
	config = function()
		require("nvim-dap-virtual-text").setup()
		require("dap-go").setup()

		local dap = require("dap")

		-- Hardcoded debug ports for each service
		local debug_services = {
			{ name = "account-api", port = 2350 },
			{ name = "cardbin-api", port = 2349 },
			{ name = "fraud-api", port = 2348 },
			{ name = "risk-api", port = 2347 },
			{ name = "router-api", port = 2345 },
			{ name = "schedule-api", port = 2352 },
			{ name = "three-ds-api", port = 2351 },
			{ name = "vault-api", port = 2346 },
		}

		-- Create a DAP configuration for each service
		local configurations = {}
		for _, service in ipairs(debug_services) do
			table.insert(configurations, {
				type = "go",
				name = "Attach to " .. service.name .. " (:" .. service.port .. ")",
				mode = "remote",
				request = "attach",
				port = service.port,
				host = "127.0.0.1",
				substitutePath = {
					{ from = "${workspaceFolder}", to = "/app" },
				},
			})
		end

		dap.configurations.go = configurations
	end,
}
