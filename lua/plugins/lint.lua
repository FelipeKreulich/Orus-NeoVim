-- Linters that the LSP servers don't cover. They run on save and only where the project has them
-- installed and configured (PHPStan: vendor/bin/phpstan + phpstan.neon), so nothing fires in
-- projects that never adopted them. ESLint already runs through its language server (lsp.lua).
return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost" },
	config = function()
		local lint = require("lint")

		lint.linters.phpstan.cmd = function()
			local local_bin = vim.fn.getcwd() .. "/vendor/bin/phpstan"
			return vim.fn.executable(local_bin) == 1 and local_bin or "phpstan"
		end
		lint.linters_by_ft = { php = { "phpstan" } }

		local function projeto_tem_phpstan(bufnr)
			return vim.fs.root(bufnr, { "phpstan.neon", "phpstan.neon.dist", "phpstan.dist.neon" }) ~= nil
		end

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function(args)
				if vim.bo[args.buf].filetype == "php" and not projeto_tem_phpstan(args.buf) then
					return
				end
				lint.try_lint()
			end,
		})
	end,
}
