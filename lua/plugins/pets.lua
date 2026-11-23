return {
  {
    "tamton-aquib/duck.nvim",
    config = function()
      local duck = require("duck")

      -- Spawn random demon
      local demons = { "😈", "👹", "👺", "☠️", "👽", "👾", "🤖", "👁", "🧛🏻", "🐉", "☢️", "🔥" }
      vim.keymap.set("n", "<leader>Pd", function()
        duck.hatch(demons[math.random(1, #demons)])
      end, { desc = "Demónio aleatório" })

      -- Spawn específicos
      vim.keymap.set("n", "<leader>Pa", function() duck.hatch("💀") end, { desc = "Caveira" })
      vim.keymap.set("n", "<leader>Pb", function() duck.hatch("🦇") end, { desc = "Morcego" })
      vim.keymap.set("n", "<leader>P1", function() duck.hatch("😈") end, { desc = "Demónio" })
      vim.keymap.set("n", "<leader>P2", function() duck.hatch("👾") end, { desc = "Alien" })
      vim.keymap.set("n", "<leader>P3", function() duck.hatch("🐉") end, { desc = "Dragão" })
      vim.keymap.set("n", "<leader>P4", function() duck.hatch("🔥") end, { desc = "Fogo" })
      vim.keymap.set("n", "<leader>P5", function() duck.hatch("🤖") end, { desc = "Robô" })

      -- Spawn horda (5 demons aleatórios de uma vez)
      vim.keymap.set("n", "<leader>Ph", function()
        for _ = 1, 5 do
          duck.hatch(demons[math.random(1, #demons)])
        end
      end, { desc = "Horda (5 de uma vez)" })

      -- Controle
      vim.keymap.set("n", "<leader>Pc", function() duck.cook() end, { desc = "Matar o último" })
      vim.keymap.set("n", "<leader>Pk", function() duck.cook_all() end, { desc = "Matar todos" })
    end,
  },
}
