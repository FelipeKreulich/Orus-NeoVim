-- Git: lazygit in a floating window, diffview for branch diffs and file history.
-- Hunk keymaps (stage, reset, blame...) are in gitsigns' on_attach in init.lua.
return {
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
			{ "<leader>gl", "<cmd>LazyGitFilterCurrentFile<CR>", desc = "Commits deste ficheiro" },
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff das alterações por gravar" },
			{
				"<leader>gm",
				function()
					-- Diff of this branch against the base branch (dev, master or main), like a PR.
					local base
					for _, b in ipairs({ "origin/dev", "origin/master", "origin/main" }) do
						vim.fn.system({ "git", "rev-parse", "--verify", "--quiet", b })
						if vim.v.shell_error == 0 then
							base = b
							break
						end
					end
					vim.cmd("DiffviewOpen " .. (base or "HEAD~1") .. "...HEAD")
				end,
				desc = "Diff do branch (como um PR)",
			},
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Histórico deste ficheiro" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Histórico do repositório" },
			{ "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Fechar o diff" },
		},
		opts = { enhanced_diff_hl = true },
	},
}
