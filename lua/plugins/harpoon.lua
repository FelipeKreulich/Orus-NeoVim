return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	},
	keys = function()
		local keys = {
			{
				"<leader>aa",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Marcar ficheiro",
			},
			{
				"<leader>am",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Menu das marcas",
			},
			{
				"<leader>ar",
				function()
					local harpoon = require("harpoon")
					local current_buf = vim.api.nvim_buf_get_name(0)
					local list = harpoon:list()
					local idx_to_remove = nil

					for i, item in ipairs(list.items) do
						if item.value == current_buf then
							idx_to_remove = i
							break
						end
					end

					if idx_to_remove then
						list:remove(idx_to_remove)
					else
						vim.notify("Este ficheiro não está marcado", vim.log.levels.WARN)
					end
				end,
				desc = "Desmarcar ficheiro",
			},
		}

		for i = 1, 5 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					require("harpoon"):list():select(i)
				end,
				desc = "Ir para a marca " .. i,
			})
		end
		return keys
	end,
}
