-- Animações sobre o código do ficheiro aberto. Precisam de um ficheiro com Treesitter
-- (num buffer vazio ou sem linguagem conhecida avisam em vez de rebentar).
local function animar(nome)
	return function()
		local ok = pcall(vim.treesitter.get_parser, 0)
		if not ok or vim.bo.filetype == "" then
			vim.notify(require("config.idioma").t("Abre um ficheiro de código primeiro (a animação usa o Treesitter)", "Open a code file first (the animation uses Treesitter)"), vim.log.levels.WARN)
			return
		end
		vim.cmd("CellularAutomaton " .. nome)
	end
end

return {
	"eandrju/cellular-automaton.nvim",
	cmd = "CellularAutomaton",
	keys = {
		{ "<leader>em", animar("make_it_rain"), desc = "Chuva de código" },
		{ "<leader>eg", animar("game_of_life"), desc = "Jogo da vida" },
	},
}
