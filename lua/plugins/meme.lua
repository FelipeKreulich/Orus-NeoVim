return {
	{ "famiu/feline.nvim" },

	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	{
		"karb94/neoscroll.nvim",
		opts = {},
		config = function()
			require("neoscroll").setup({
				mappings = { -- Keys to be mapped to their corresponding default scrolling animation
					"<C-u>",
					"<C-d>",
					"<C-b>",
					"<C-f>",
					"<C-y>",
					"<C-e>",
					"zt",
					"zz",
					"zb",
				},
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				duration_multiplier = 1.0, -- Global duration multiplier
				easing = "linear", -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
				performance_mode = false, -- Disable "Performance Mode" on all buffers.
				ignored_events = { -- Events ignored while scrolling
					"WinScrolled",
					"CursorMoved",
				},
			})
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		-- Carrega quando for necessário, por exemplo em buffer read
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.opt.foldcolumn = "1" -- mostra coluna de folds
			vim.opt.foldlevel = 99 -- nível alto para não fechar tudo automaticamente
			vim.opt.foldlevelstart = 99 -- no início do buffer já estar “aberto” quase tudo
			vim.opt.foldenable = true -- ativar folding

			-- Mapeamentos para abrir / fechar todos
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			-- Configuração do ufo
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					-- podes escolher qual provider (LSP, treesitter, indent) usar em cada caso
					return { "lsp", "indent" }
				end,
				-- se quiseres podes customizar preview, virt text, etc.
				-- ex: fold_virt_text_handler = my_handler,
				-- ex: close_fold_kinds_for_ft = ...
			})
		end,
	},
}
