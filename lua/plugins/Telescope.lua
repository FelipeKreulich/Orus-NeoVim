-- This configuration assumes you're using a plugin manager like lazy.nvim

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
	},
	config = function()
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use Telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of `help_tags` options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			-- pickers = {}
			defaults = {
				hidden = true, -- Show hidden files
				file_ignore_patterns = { "%.git/", "vendor", "node_modules", "%.md", "%.sh", "%.github/" }, -- Ignore `.git/` folder
			},
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Ajuda do Neovim" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Atalhos (todos)" })
		vim.keymap.set("n", "<leader>sf", function()
			builtin.find_files({
				hidden = true,
			})
		end, { desc = "Ficheiros" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Pesquisas do Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Palavra debaixo do cursor" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Texto no projeto (grep)" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Diagnósticos" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Retomar a última pesquisa" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Ficheiros recentes" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Buffers abertos" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Procurar no ficheiro" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "Procurar nos ficheiros abertos" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Configuração do Neovim" })

		-- Search TODOs with Telescope (requires todo-comments.nvim)
		vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "TODOs" })
	end,
}
