-- Language of the config: Portuguese (default) or English.
-- Switch with <Space>ti or :Idioma pt|en. The choice is saved in stdpath("data")/idioma.
--
-- What it covers: every description shown by which-key (the <Space> menu, g, z, [, ], marks,
-- registers...), the which-key footer, the cheatsheet (<Space>?) and this config's own messages.
-- Neovim's built-in error messages follow :language messages, but only if Neovim was built with
-- translations (Homebrew's build is not), so they usually stay in English.
local M = {}

local ficheiro = vim.fn.stdpath("data") .. "/idioma"
local dicionario = require("config.traducoes")

-- Patterns tried when there is no exact match (English -> Portuguese).
local padroes = {
	{ "^(%d+) keymaps?$", "%1 atalhos" },
	{ "^:help (.*)$", "Ajuda: %1" },
}

-- Prefixes kept in front of a translated description: { English, Portuguese }.
local prefixos = { { "LSP: ", "LSP: " }, { "Java: ", "Java: " }, { "Git Conflict: ", "Conflito Git: " } }

local inverso = {}
for en, pt in pairs(dicionario) do
	inverso[pt] = inverso[pt] or en
end
local padroes_en = {
	{ "^(%d+) atalhos$", "%1 keymaps" },
	{ "^Ajuda: (.*)$", ":help %1" },
	{ "^Tema: (.*)$", "Theme: %1" },
}

function M.atual()
	if vim.g.idioma then
		return vim.g.idioma
	end
	local ok, linhas = pcall(vim.fn.readfile, ficheiro)
	vim.g.idioma = (ok and linhas[1] == "en") and "en" or "pt"
	return vim.g.idioma
end

--- Picks the text for the current language: M.t("Olá", "Hello").
function M.t(pt, en)
	return M.atual() == "en" and en or pt
end

local function por_padrao(texto, lista)
	for _, p in ipairs(lista) do
		local novo, n = texto:gsub(p[1], p[2])
		if n > 0 then
			return novo
		end
	end
end

--- Translates a description to the current language (keeps prefixes like "LSP: " and "Java: ").
function M.traduzir(texto)
	if type(texto) ~= "string" or texto == "" then
		return texto
	end
	local pt = M.atual() == "pt"
	for _, p in ipairs(prefixos) do
		local de, para = p[pt and 1 or 2], p[pt and 2 or 1]
		if texto:sub(1, #de) == de and #texto > #de then
			return para .. M.traduzir(texto:sub(#de + 1))
		end
	end
	if M.atual() == "pt" then
		return dicionario[texto] or por_padrao(texto, padroes) or texto
	end
	return inverso[texto] or por_padrao(texto, padroes_en) or texto
end

local function aplicar_mensagens()
	-- Neovim's own messages (errors, :w, etc.). Only works if the locale exists on the system.
	local alvo = M.atual() == "pt" and { "pt_PT.UTF-8", "pt_BR.UTF-8" } or { "en_US.UTF-8", "C" }
	for _, loc in ipairs(alvo) do
		if pcall(vim.cmd, "silent language messages " .. loc) then
			return
		end
	end
end

function M.definir(lingua)
	lingua = (lingua == "en") and "en" or "pt"
	vim.g.idioma = lingua
	pcall(vim.fn.writefile, { lingua }, ficheiro)
	aplicar_mensagens()
	vim.notify(M.t("Idioma: Português", "Language: English"))
end

function M.alternar()
	M.definir(M.atual() == "pt" and "en" or "pt")
end

--- Hooks the translation into which-key (descriptions and the close/back/scroll footer).
function M.ligar_which_key()
	local cfg = require("which-key.config")
	table.insert(cfg.options.replace.desc, function(desc)
		return M.traduzir(desc)
	end)
	local Text = require("which-key.text")
	local append = Text.append
	local rodape = { [" close"] = " fechar", [" back"] = " voltar", [" scroll"] = " deslizar" }
	Text.append = function(self, texto, opts)
		if type(texto) == "string" and rodape[texto] and M.atual() == "pt" then
			texto = rodape[texto]
		end
		return append(self, texto, opts)
	end
end

function M.setup()
	M.atual()
	aplicar_mensagens()
	vim.api.nvim_create_user_command("Idioma", function(o)
		if o.args == "" then
			M.alternar()
		else
			M.definir(o.args)
		end
	end, {
		nargs = "?",
		complete = function()
			return { "pt", "en" }
		end,
		desc = "Idioma / language: pt | en",
	})
end

return M
