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
			-- Define as cores manualmente
			vim.cmd([[
        hi IblIndentRed guifg=#ff5555
        hi IblIndentYellow guifg=#f1fa8c
        hi IblIndentBlue guifg=#8be9fd
        hi IblIndentGreen guifg=#50fa7b
        hi IblIndentCyan guifg=#8be9fd
      ]])
			require("ibl").setup(opts)
		end,
	},
}
