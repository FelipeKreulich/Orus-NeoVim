-- Run tests from the editor with results next to each test: PHPUnit (Laravel), Jest and Vitest.
-- Java tests run through jdtls (<Space>jt / <Space>jT).
local function phpunit_cmd()
	-- POP's backend runs on PHP 8.3; use it when installed, otherwise the default php.
	local php = vim.fn.executable("/opt/homebrew/opt/php@8.3/bin/php") == 1 and "/opt/homebrew/opt/php@8.3/bin/php"
		or "php"
	return { php, "vendor/bin/phpunit" }
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-phpunit",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	keys = {
		{ "<leader>rr", function() require("neotest").run.run() end, desc = "Correr o teste mais próximo" },
		{ "<leader>rf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Correr os testes do ficheiro" },
		{ "<leader>ra", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Correr todos os testes" },
		{ "<leader>rl", function() require("neotest").run.run_last() end, desc = "Repetir o último" },
		{ "<leader>rx", function() require("neotest").run.stop() end, desc = "Parar os testes" },
		{ "<leader>rs", function() require("neotest").summary.toggle() end, desc = "Painel dos testes" },
		{ "<leader>ro", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Ver o resultado" },
		{ "<leader>rp", function() require("neotest").output_panel.toggle() end, desc = "Painel do output" },
		{ "]r", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Teste falhado seguinte" },
		{ "[r", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Teste falhado anterior" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-phpunit")({ phpunit_cmd = phpunit_cmd }),
				require("neotest-jest")({}),
				require("neotest-vitest")({}),
			},
		})
	end,
}
