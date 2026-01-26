local M = {}

local function is_floating(win)
	local cfg = vim.api.nvim_win_get_config(win)
	return cfg and (cfg.relative ~= "" and cfg.relative ~= nil)
end

local function sort_windows(wins)
	table.sort(wins, function(a, b)
		local ay, ax = unpack(vim.api.nvim_win_get_position(a))
		local by, bx = unpack(vim.api.nvim_win_get_position(b))
		if ax == bx then
			return ay < by
		end
		return ax < bx
	end)
	return wins
end

function M.goto_split(n)
	local wins = vim.api.nvim_tabpage_list_wins(0)
	local normal = {}
	for _, w in ipairs(wins) do
		if not is_floating(w) then
			table.insert(normal, w)
		end
	end
	sort_windows(normal)
	if n <= #normal then
		vim.api.nvim_set_current_win(normal[n])
	else
		vim.notify("No such split: " .. n, vim.log.levels.WARN)
	end
end

return M
