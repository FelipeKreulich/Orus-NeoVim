return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>SS", function() require("spectre").toggle() end, desc = "Procurar e substituir no projeto" },
    { "<leader>Sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Substituir a palavra debaixo do cursor" },
    { "<leader>Sf", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Substituir neste ficheiro" },
  },
}
