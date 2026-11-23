return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	-- Descriptions are translated on the fly (PT by default, EN optional): see config/idioma.lua.
	config = function(_, opts)
		require("which-key").setup(opts)
		require("config.idioma").ligar_which_key()
	end,
	opts = {
		-- delay between pressing a key and opening which-key (milliseconds)
		-- this setting is independent of vim.opt.timeoutlen
		delay = 0,
		icons = {
			-- set icon mappings to true if you have a Nerd Font
			mappings = vim.g.have_nerd_font,
			-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
			-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
			keys = vim.g.have_nerd_font and {} or {
				Up = "<Up> ",
				Down = "<Down> ",
				Left = "<Left> ",
				Right = "<Right> ",
				C = "<C-…> ",
				M = "<M-…> ",
				D = "<D-…> ",
				S = "<S-…> ",
				CR = "<CR> ",
				Esc = "<Esc> ",
				ScrollWheelDown = "<ScrollWheelDown> ",
				ScrollWheelUp = "<ScrollWheelUp> ",
				NL = "<NL> ",
				BS = "<BS> ",
				Space = "<Space> ",
				Tab = "<Tab> ",
				F1 = "<F1>",
				F2 = "<F2>",
				F3 = "<F3>",
				F4 = "<F4>",
				F5 = "<F5>",
				F6 = "<F6>",
				F7 = "<F7>",
				F8 = "<F8>",
				F9 = "<F9>",
				F10 = "<F10>",
				F11 = "<F11>",
				F12 = "<F12>",
			},
		},

		-- Grupos do menu do <Espaço> (em português). Cosmética no fim, em maiúsculas.
		spec = {
			{ "<leader>a", group = "Marcas (Harpoon)", icon = "󰛢" },
			{ "<leader>b", group = "Debug", icon = "󰃤" },
			{ "<leader>c", group = "Código", mode = { "n", "x" }, icon = "󰅩" },
			{ "<leader>j", group = "Java / Spring", icon = "󰬷" },
			{ "<leader>p", group = "Sessões", icon = "󰆓" },
			{ "<leader>s", group = "Procurar", icon = "󰍉" },
			{ "<leader>t", group = "Temas e opções", icon = "󰏘" },
			{ "<leader>x", group = "Problemas e TODOs", icon = "󱖫" },
			{ "<leader>S", group = "Substituir (Spectre)", icon = "󰈁" },
			{ "<leader>n", group = "Ficheiros e pastas", icon = "󰉋" },
			{ "<leader>nf", function() require("config.ficheiros").novo_ficheiro() end, desc = "Novo ficheiro" },
			{ "<leader>nd", function() require("config.ficheiros").nova_pasta() end, desc = "Nova pasta" },
			{ "<leader>nr", function() require("config.ficheiros").renomear() end, desc = "Renomear este ficheiro" },
			{ "<leader>nx", function() require("config.ficheiros").apagar() end, desc = "Apagar este ficheiro" },
			{ "<leader>ny", function() require("config.ficheiros").copiar_caminho() end, desc = "Copiar o caminho" },
			{ "<leader>ne", "<cmd>Neotree reveal<CR>", desc = "Mostrar no explorador" },
			{ "<leader>g", group = "Git", mode = { "n", "v" }, icon = "󰊢" },
			{ "<leader>d", group = "Base de dados", icon = "󰆼" },
			{ "<leader>r", group = "Testes", icon = "󰙨" },
			-- Cosmética
			{ "<leader>e", group = "Efeitos", icon = "󰙴" },
			{ "<leader>E", group = "Ecrãs hacker", icon = "󰊠" },
			{ "<leader>P", group = "Patos", icon = "󰇥" },
			-- Harpoon 1-5: funcionam, mas não ocupam o menu
			{ "<leader>1", hidden = true },
			{ "<leader>2", hidden = true },
			{ "<leader>3", hidden = true },
			{ "<leader>4", hidden = true },
			{ "<leader>5", hidden = true },
			{
				"<leader>ti",
				function()
					require("config.idioma").alternar()
				end,
				desc = "Idioma: PT / EN",
				icon = "󰗊",
			},
			-- Cábula com todos os atalhos
			{
				"<leader>?",
				function()
					require("config.cabula").abrir()
				end,
				desc = "Cábula: todos os atalhos",
				icon = "󰌌",
			},
		},
	},
}
