return {
	{ "nvim-tree/nvim-web-devicons" },
	-- bar tab
	--
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				sidebars = "dark",
				floats = "dark",
			},
			sidebars = { "qf", "help", "neo-tree", "terminal", "trouble" },
			on_highlights = function(hl, c)
				hl.LineNr = { fg = c.dark5 }
				hl.CursorLineNr = { fg = c.orange, bold = true }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd([[colorscheme tokyonight-night]])

			-- Atalhos para trocar de tema rapidamente
			vim.keymap.set("n", "<leader>tt", function()
				vim.cmd("colorscheme tokyonight-night")
				vim.notify("Tema: Tokyo Night", vim.log.levels.INFO)
			end, { desc = "Tema: Tokyo Night" })

			vim.keymap.set("n", "<leader>tm", function()
				vim.cmd("colorscheme midnight")
				vim.notify("Tema: Midnight (preto puro)", vim.log.levels.INFO)
			end, { desc = "Tema: Midnight" })

			vim.keymap.set("n", "<leader>tc", function()
				vim.cmd("colorscheme cyberdream")
				vim.notify("Tema: Cyberdream", vim.log.levels.INFO)
			end, { desc = "Tema: Cyberdream" })
		end,
	},
	{
		{
			"romgrk/barbar.nvim",
			dependencies = {
				"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
				"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
			},
			init = function()
				vim.g.barbar_auto_setup = false
			end,
			opts = {
				animation = true,
				auto_hide = false,
				tabpages = true,
				clickable = true,
				focus_on_close = "left",
				hide = { inactive = false }, -- Set to false to always show all buffers
				highlight_visible = true,
				exclude_ft = { "" },
				exclude_name = { "" },
				no_name_title = nil,
				icons = {
					buffer_index = false,
					buffer_number = false,
					button = "",
					filetype = {
						custom_colors = false,
						enabled = true,
					},
					separator = { left = "▎", right = "" },
					separator_at_end = true,
					modified = { button = "●" },
					pinned = { button = "", filename = true },
					preset = "default",
				},
			},
			version = "^1.0.0",
		},
	},
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v3.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	config = function()
	-- 		vim.api.nvim_set_keymap("n", "<C-e>", ":Neotree toggle<CR>", {
	-- 			noremap = true,
	-- 			silent = true,
	-- 			desc = "Open File Explorer",
	-- 		})
	-- 	end,
	-- },
	{
		"vyfor/cord.nvim",
		build = ":Cord update",
		event = "VeryLazy",
		config = function()
			require("cord").setup({
				usercmds = true,
				log_level = "info",
				timer = {
					interval = 1500,
					reset_on_idle = false,
					reset_on_change = false,
				},
				editor = {
					image = nil,
					client_id = "365525338924646402",
					tooltip = "The One True Text Editor",
				},
				display = {
					show_time = true,
					show_repository = true,
					show_cursor_position = false,
					swap_fields = false,
					swap_icons = false,
					workspace_blacklist = {},
					theme = "default",
				},
				lsp = {
					show_problem_count = false,
					severity = 1,
					scope = "workspace",
				},
				idle = {
					enable = true,
					show_status = true,
					timeout = 300000,
					disable_on_focus = true,
					text = "Idle",
					tooltip = "💤",
				},
				text = {
					viewing = "My life <3",
					editing = "My life <3",
					file_browser = "Browsing files in {}",
					plugin_manager = "Managing plugins in {}",
					lsp_manager = "Configuring LSP in {}",
					vcs = "Committing changes in {}",
					workspace = "In {}",
				},
			})
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true, -- Close Neo-tree when it's the last window
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = false,
				sort_case_insensitive = true,

				filesystem = {
					filtered_items = {
						visible = true, -- Show hidden files
						hide_dotfiles = false, -- Don't hide dotfiles (.env, .gitignore, etc.)
						hide_gitignored = true,
					},
					follow_current_file = {
						enabled = true, -- Focus the current file in the tree
					},
					hijack_netrw_behavior = "open_default",
					use_libuv_file_watcher = true,
				},

				window = {
					position = "left",
					width = 32,
					mappings = {
						["<space>"] = "toggle_node",
						["<cr>"] = "open",
						["a"] = { "add", config = { show_path = "relative" } }, -- Create new file/folder
						["A"] = "add_directory", -- Create directory
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["q"] = "close_window",
					},
				},
			})

			-- 🗂️ Keybindings
			vim.keymap.set("n", "<C-b>", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

			-- vim.keymap.set("n", "<C-k>", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })
		end,
	},
}
