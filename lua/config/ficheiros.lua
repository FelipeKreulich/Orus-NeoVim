-- Criar, renomear e apagar ficheiros e pastas sem sair do ficheiro atual (<Espaço>n).
-- Os caminhos são relativos à pasta de trabalho (:pwd) e as pastas que faltam são criadas.
local M = {}
local t = function(pt, en)
	return require("config.idioma").t(pt, en)
end

local function pasta_atual()
	local nome = vim.api.nvim_buf_get_name(0)
	local pasta = nome ~= "" and vim.fn.fnamemodify(nome, ":.:h") or "."
	return pasta == "." and "" or pasta .. "/"
end

function M.novo_ficheiro()
	vim.ui.input({ prompt = t("Novo ficheiro: ", "New file: "), default = pasta_atual(), completion = "file" }, function(caminho)
		if not caminho or caminho == "" or caminho:sub(-1) == "/" then
			return
		end
		vim.fn.mkdir(vim.fn.fnamemodify(caminho, ":h"), "p")
		vim.cmd.edit(vim.fn.fnameescape(caminho))
		vim.cmd.write()
	end)
end

function M.nova_pasta()
	vim.ui.input({ prompt = t("Nova pasta: ", "New folder: "), default = pasta_atual(), completion = "dir" }, function(caminho)
		if not caminho or caminho == "" then
			return
		end
		vim.fn.mkdir(caminho, "p")
		vim.notify(t("Pasta criada: ", "Folder created: ") .. caminho)
	end)
end

function M.renomear()
	local antigo = vim.fn.expand("%:.")
	if antigo == "" then
		return vim.notify(t("Este buffer não tem ficheiro", "This buffer has no file"), vim.log.levels.WARN)
	end
	vim.ui.input({ prompt = t("Renomear para: ", "Rename to: "), default = antigo, completion = "file" }, function(novo)
		if not novo or novo == "" or novo == antigo then
			return
		end
		if vim.fn.filereadable(novo) == 1 then
			return vim.notify(t("Já existe: ", "Already exists: ") .. novo, vim.log.levels.ERROR)
		end
		local buf_antigo = vim.api.nvim_get_current_buf()
		if vim.bo.modified then
			vim.cmd.write()
		end
		vim.fn.mkdir(vim.fn.fnamemodify(novo, ":h"), "p")
		if vim.fn.rename(antigo, novo) ~= 0 then
			return vim.notify(t("Não consegui renomear", "Could not rename"), vim.log.levels.ERROR)
		end
		vim.cmd.edit(vim.fn.fnameescape(novo))
		vim.api.nvim_buf_delete(buf_antigo, { force = true })
		vim.notify(antigo .. " → " .. novo)
	end)
end

function M.apagar()
	local ficheiro = vim.fn.expand("%:.")
	if ficheiro == "" then
		return
	end
	if vim.fn.confirm(t("Apagar ", "Delete ") .. ficheiro .. "?", t("&Sim\n&Não", "&Yes\n&No"), 2) ~= 1 then
		return
	end
	local buf = vim.api.nvim_get_current_buf()
	if vim.fn.delete(ficheiro) ~= 0 then
		return vim.notify(t("Não consegui apagar", "Could not delete"), vim.log.levels.ERROR)
	end
	vim.api.nvim_buf_delete(buf, { force = true })
	vim.notify(t("Apagado: ", "Deleted: ") .. ficheiro)
end

function M.copiar_caminho()
	local caminho = vim.fn.expand("%:.")
	if caminho == "" then
		return vim.notify(t("Este buffer não tem ficheiro", "This buffer has no file"), vim.log.levels.WARN)
	end
	vim.fn.setreg("+", caminho)
	vim.notify(t("Copiado: ", "Copied: ") .. caminho)
end

return M
