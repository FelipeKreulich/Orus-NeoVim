return {
  {
    "tamton-aquib/duck.nvim",
    config = function()
      -- Space+d+d = spawn um pato
      -- Space+d+k = matar todos os patos
      -- Space+d+a = spawn mais bichos
      vim.keymap.set("n", "<leader>dd", function() require("duck").hatch("🐈") end, { desc = "Spawn gato" })
      vim.keymap.set("n", "<leader>da", function() require("duck").hatch("💀") end, { desc = "Spawn caveira" })
      vim.keymap.set("n", "<leader>db", function() require("duck").hatch("🦇") end, { desc = "Spawn morcego" })
      vim.keymap.set("n", "<leader>dc", function() require("duck").cook() end, { desc = "Matar ultimo" })
      vim.keymap.set("n", "<leader>dk", function() require("duck").cook_all() end, { desc = "Matar todos" })
    end,
  },
}
