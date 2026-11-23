-- Databases inside Neovim: vim-dadbod + UI + SQL completion.
-- Connections are added with <Space>da (or :DBUIAddConnection) and saved by dadbod-ui in
-- stdpath("data")/db_ui, outside this repo, so passwords never end up on GitHub.
-- A remote MySQL reached through an SSH tunnel works as mysql://user@127.0.0.1:<local port>/db.
return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		keys = {
			{ "<leader>dd", "<cmd>DBUIToggle<CR>", desc = "Painel das bases de dados" },
			{ "<leader>da", "<cmd>DBUIAddConnection<CR>", desc = "Nova ligação" },
			{ "<leader>df", "<cmd>DBUIFindBuffer<CR>", desc = "Ligar este ficheiro SQL a uma base" },
		},
		init = function()

			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1
			vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
			-- SQL completion (tables, columns) through nvim-cmp in SQL buffers.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					local ok, cmp = pcall(require, "cmp")
					if ok then
						cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" }, { name = "buffer" } } })
					end
				end,
			})
		end,
	},
}
