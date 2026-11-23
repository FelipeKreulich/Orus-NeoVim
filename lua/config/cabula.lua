-- Cábula: abre o cabula.md (na raiz da config) numa janela flutuante, só de leitura.
-- <Espaço>? para abrir; q ou <Esc> para fechar. Para editar: :e ~/.config/nvim/cabula.md
local M = {}

function M.abrir()
	local idioma = require("config.idioma")
	local ficheiro = vim.fn.stdpath("config") .. (idioma.atual() == "en" and "/cabula.en.md" or "/cabula.md")
	local linhas = vim.fn.filereadable(ficheiro) == 1 and vim.fn.readfile(ficheiro) or { "Falta o " .. ficheiro }

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, linhas)
	vim.bo[buf].filetype = "markdown"
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"

	local largura = math.min(100, vim.o.columns - 4)
	local altura = math.min(#linhas, vim.o.lines - 6)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = largura,
		height = altura,
		row = math.floor((vim.o.lines - altura) / 2) - 1,
		col = math.floor((vim.o.columns - largura) / 2),
		style = "minimal",
		border = "rounded",
		title = idioma.t(" Cábula · q para fechar · / para procurar ", " Cheatsheet · q to close · / to search "),
		title_pos = "center",
	})
	vim.wo[win].conceallevel = 2
	vim.wo[win].cursorline = true

	for _, tecla in ipairs({ "q", "<Esc>" }) do
		vim.keymap.set("n", tecla, "<cmd>close<CR>", { buffer = buf, nowait = true })
	end
end

vim.api.nvim_create_user_command("Cabula", M.abrir, { desc = "Cábula / cheatsheet" })

return M
