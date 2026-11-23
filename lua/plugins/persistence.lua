return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<leader>ps", function() require("persistence").load() end, desc = "Restaurar a sessão desta pasta" },
    { "<leader>pS", function() require("persistence").select() end, desc = "Escolher sessão" },
    { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "Restaurar a última sessão" },
    { "<leader>pd", function() require("persistence").stop() end, desc = "Não gravar esta sessão" },
  },
}
