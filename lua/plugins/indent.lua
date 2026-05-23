return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "┊", -- caractere da linha de indentação
				highlight = {
					"IblIndentRed",
					"IblIndentYellow",
					"IblIndentBlue",
					"IblIndentGreen",
					"IblIndentCyan",
				},
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
			},
		},
		config = function(_, opts)
			local function define_highlights()
				vim.api.nvim_set_hl(0, "IblIndentRed",    { fg = "#ff5555" })
				vim.api.nvim_set_hl(0, "IblIndentYellow", { fg = "#f1fa8c" })
				vim.api.nvim_set_hl(0, "IblIndentBlue",   { fg = "#8be9fd" })
				vim.api.nvim_set_hl(0, "IblIndentGreen",  { fg = "#50fa7b" })
				vim.api.nvim_set_hl(0, "IblIndentCyan",   { fg = "#8be9fd" })
			end

			-- Registar ANTES do ibl.setup para correr antes do autocmd interno do IBL
			-- Garante que os highlight groups existem quando o IBL os tenta usar
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = define_highlights,
			})

			define_highlights()
			require("ibl").setup(opts)
		end,
	},
}
