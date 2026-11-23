-- jdtls (LSP do Java) por projeto, com testes, debug e as extensões do Spring Boot.
-- Plugins em lua/plugins/java.lua; ferramentas instaladas pelo Mason (lua/plugins/lsp.lua).
local ok, jdtls = pcall(require, "jdtls")
if not ok then
	return
end

-- O jdtls atual (2026-11) só corre em Java 25 (o `java` no PATH é o 17). Procura-se o JDK 25 do
-- Homebrew (`brew install openjdk@25`) e, se não houver, o que o Gradle descarrega para a toolchain
-- em ~/.gradle/jdks. O Java 21 fica como runtime extra para projetos mais antigos.
local jdk21 = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
local mason = vim.fn.stdpath("data") .. "/mason"

local function jdk(versao)
	local candidatos = {
		"/opt/homebrew/opt/openjdk@" .. versao .. "/libexec/openjdk.jdk/Contents/Home",
	}
	-- ~/.gradle/jdks/<vendor>-<versao>-.../jdk-<versao>.../Contents/Home
	vim.list_extend(candidatos, vim.fn.glob(vim.fn.expand("~/.gradle/jdks") .. "/*-" .. versao .. "-*/*/Contents/Home", false, true))
	for _, home in ipairs(candidatos) do
		if vim.fn.executable(home .. "/bin/java") == 1 then
			return home
		end
	end
end

local jdk25 = jdk("25")
if not jdk25 then
	vim.notify("jdtls: falta o JDK 25 (brew install openjdk@25)", vim.log.levels.WARN)
	return
end

local root = vim.fs.root(0, { "gradlew", "mvnw", "settings.gradle.kts", "pom.xml", ".git" })
if not root then
	return
end

-- Um workspace do jdtls por projeto (índices e cache), fora do projeto.
local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fs.basename(root) .. "-" .. vim.fn.sha256(root):sub(1, 8)

-- Extensões do jdtls: debug, testes (JUnit) e Spring Boot.
local bundles = vim.fn.glob(mason .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", false, true)
for _, jar in ipairs(vim.fn.glob(mason .. "/packages/java-test/extension/server/*.jar", false, true)) do
	-- Estes dois são do runner de testes, não extensões do jdtls.
	if not jar:match("com%.microsoft%.java%.test%.runner%-jar%-with%-dependencies%.jar$") and not jar:match("jacocoagent%.jar$") then
		table.insert(bundles, jar)
	end
end
local ok_spring, spring_boot = pcall(require, "spring_boot")
if ok_spring then
	vim.list_extend(bundles, spring_boot.java_extensions())
end

local runtimes = {
	{ name = "JavaSE-21", path = jdk21 },
	{ name = "JavaSE-25", path = jdk25, default = true },
}

-- Comandos do Gradle num terminal flutuante (toggleterm), na raiz do projeto.
local function gradle(tarefa)
	return function()
		require("toggleterm.terminal").Terminal
			:new({ cmd = "./gradlew " .. tarefa, dir = root, direction = "float", close_on_exit = false })
			:toggle()
	end
end

local config = {
	name = "jdtls",
	cmd = { mason .. "/bin/jdtls", "-data", workspace },
	cmd_env = { JAVA_HOME = jdk25 },
	root_dir = root,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		java = {
			configuration = { runtimes = runtimes, updateBuildConfiguration = "interactive" },
			import = { gradle = { enabled = true, wrapper = { enabled = true } } },
			eclipse = { downloadSources = true },
			maven = { downloadSources = true },
			references = { includeDecompiledSources = true },
			contentProvider = { preferred = "fernflower" },
			signatureHelp = { enabled = true },
			inlayHints = { parameterNames = { enabled = "literals" } },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.assertj.core.api.Assertions.*",
					"org.mockito.Mockito.*",
					"org.mockito.ArgumentMatchers.*",
				},
				importOrder = { "java", "javax", "jakarta", "org", "com", "pt" },
			},
			sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
		},
	},
	init_options = {
		bundles = bundles,
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
	on_attach = function(_, bufnr)
		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()

		local map = function(modo, teclas, acao, desc)
			vim.keymap.set(modo, teclas, acao, { buffer = bufnr, desc = "Java: " .. desc })
		end
		-- Código
		map("n", "<leader>jo", jdtls.organize_imports, "Organizar imports")
		map("n", "<leader>jv", jdtls.extract_variable, "Extrair variável")
		map("x", "<leader>jv", function() jdtls.extract_variable(true) end, "Extrair variável")
		map("n", "<leader>jc", jdtls.extract_constant, "Extrair constante")
		map("x", "<leader>jm", function() jdtls.extract_method(true) end, "Extrair método")
		map("n", "<leader>ju", "<cmd>JdtUpdateConfig<CR>", "Recarregar o projeto (Gradle)")
		-- Testes (com debug)
		map("n", "<leader>jt", jdtls.test_nearest_method, "Correr o teste mais próximo")
		map("n", "<leader>jT", jdtls.test_class, "Correr os testes da classe")
		-- Gradle
		map("n", "<leader>jr", gradle("bootRun"), "Arrancar a app (bootRun)")
		map("n", "<leader>jg", gradle("test"), "Gradle: todos os testes")
		map("n", "<leader>jb", gradle("build"), "Gradle: build")
	end,
}

jdtls.start_or_attach(config)
