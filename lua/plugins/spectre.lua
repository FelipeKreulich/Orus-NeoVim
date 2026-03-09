return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>S", function() require("spectre").toggle() end, desc = "Spectre: Search & Replace" },
    { "<leader>Sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Spectre: Search current word" },
    { "<leader>Sf", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Spectre: Search in file" },
  },
}
