-- Java e Spring Boot (POP 2.0: pop-api).
--
-- O jdtls (LSP do Java) arranca em ftplugin/java.lua, por projeto, através do nvim-jdtls; não passa
-- pelo mason-lspconfig (ver o `automatic_enable` em lsp.lua). O spring-boot.nvim junta o LSP do
-- Spring Boot (application.yaml, beans, endpoints) e as extensões do Spring ao jdtls.
local jdk21 = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"

return {
	{ "mfussenegger/nvim-jdtls", ft = "java" },

	{
		"JavaHello/spring-boot.nvim",
		ft = { "java", "yaml", "jproperties" },
		dependencies = { "mfussenegger/nvim-jdtls" },
		opts = {
			-- O servidor do Spring Boot precisa de Java 21+ (o `java` no PATH é o 17).
			java_cmd = jdk21 .. "/bin/java",
			-- Só arranca em projetos Spring Boot (não em qualquer YAML).
			project_filter = function(root_dir)
				return require("spring_boot.util").has_spring_boot_dependency(root_dir)
			end,
		},
	},

	-- Debug (Java e o que vier): F5 continuar, F10 por cima, F11 para dentro, F12 para fora.
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
		},
		keys = {
			{ "<F5>", function() require("dap").continue() end, desc = "Debug: continuar / arrancar" },
			{ "<F10>", function() require("dap").step_over() end, desc = "Debug: passo por cima" },
			{ "<F11>", function() require("dap").step_into() end, desc = "Debug: passo para dentro" },
			{ "<F12>", function() require("dap").step_out() end, desc = "Debug: passo para fora" },
			{ "<leader>bb", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
			{
				"<leader>bc",
				function()
					require("dap").set_breakpoint(vim.fn.input("Condição: "))
				end,
				desc = "Breakpoint condicional",
			},
			{ "<leader>bu", function() require("dapui").toggle() end, desc = "Painel do debug" },
			{ "<leader>bq", function() require("dap").terminate() end, desc = "Terminar o debug" },
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui"] = function() dapui.close() end
		end,
	},
}
