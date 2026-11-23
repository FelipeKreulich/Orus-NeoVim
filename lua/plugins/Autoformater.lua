return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Formatar ficheiro",
		},
	},
	opts = function()
		-- Format on save only where the project has adopted the formatter (its config file exists).
		-- Projects without it (e.g. a Laravel app without Pint) are never reformatted on save, so PRs
		-- don't fill up with unrelated changes. <Space>f still formats on demand.
		local adotado = {
			php = { "pint.json", "vendor/bin/pint" },
			blade = { ".bladeformatterrc", ".bladeformatterrc.json" },
			prettier = {
				".prettierrc", ".prettierrc.json", ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.mjs",
				".prettierrc.yaml", ".prettierrc.yml", "prettier.config.js", "prettier.config.cjs", "prettier.config.mjs",
			},
			kotlin = { ".editorconfig" },
			swift = { ".swiftformat" },
		}
		local por_ft = {
			php = "php", blade = "blade", kotlin = "kotlin", swift = "swift",
			javascript = "prettier", javascriptreact = "prettier", typescript = "prettier", typescriptreact = "prettier",
			vue = "prettier", json = "prettier", jsonc = "prettier", yaml = "prettier", css = "prettier",
			scss = "prettier", html = "prettier", markdown = "prettier",
		}
		local function projeto_usa(bufnr, ficheiros)
			return vim.fs.root(bufnr, ficheiros) ~= nil
		end

		local prettier = { "prettierd", "prettier", stop_after_first = true }
		return {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local ft = vim.bo[bufnr].filetype
				if ft == "c" or ft == "cpp" then
					return
				end
				local grupo = por_ft[ft]
				if grupo then
					-- Never fall back to the LSP formatter here: it would reformat whole files too.
					if not projeto_usa(bufnr, adotado[grupo]) then
						return
					end
					return { timeout_ms = 3000, lsp_format = "never" }
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				php = { "pint" },
				blade = { "blade-formatter" },
				javascript = prettier,
				javascriptreact = prettier,
				typescript = prettier,
				typescriptreact = prettier,
				vue = prettier,
				json = prettier,
				jsonc = prettier,
				yaml = prettier,
				css = prettier,
				scss = prettier,
				html = prettier,
				markdown = prettier,
				kotlin = { "ktlint" },
				swift = { "swiftformat" },
			},
		}
	end,
}
