local M = {}

local function is_floating(win)
	local cfg = vim.api.nvim_win_get_config(win)
	return cfg and cfg.relative ~= nil and cfg.relative ~= ""
end

local function ordered_windows()
	local wins = {}
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if not is_floating(w) then
			table.insert(wins, w)
		end
	end
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
	local wins = ordered_windows()
	if n <= #wins then
		vim.api.nvim_set_current_win(wins[n])
	else
		vim.notify("No such split: " .. n, vim.log.levels.WARN)
	end
end

return M
