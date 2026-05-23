return {
  {
    "tamton-aquib/duck.nvim",
    config = function()
      local duck = require("duck")

      -- Spawn random demon
      local demons = { "😈", "👹", "👺", "☠️", "👽", "👾", "🤖", "👁", "🧛🏻", "🐉", "☢️", "🔥" }
      vim.keymap.set("n", "<leader>dd", function()
        duck.hatch(demons[math.random(1, #demons)])
      end, { desc = "Spawn demon aleatório" })

      -- Spawn específicos
      vim.keymap.set("n", "<leader>da", function() duck.hatch("💀") end, { desc = "Spawn caveira" })
      vim.keymap.set("n", "<leader>db", function() duck.hatch("🦇") end, { desc = "Spawn morcego" })
      vim.keymap.set("n", "<leader>d1", function() duck.hatch("😈") end, { desc = "Spawn demon" })
      vim.keymap.set("n", "<leader>d2", function() duck.hatch("👾") end, { desc = "Spawn alien" })
      vim.keymap.set("n", "<leader>d3", function() duck.hatch("🐉") end, { desc = "Spawn dragão" })
      vim.keymap.set("n", "<leader>d4", function() duck.hatch("🔥") end, { desc = "Spawn fogo" })
      vim.keymap.set("n", "<leader>d5", function() duck.hatch("🤖") end, { desc = "Spawn robot" })

      -- Spawn horda (5 demons aleatórios de uma vez)
      vim.keymap.set("n", "<leader>dh", function()
        for _ = 1, 5 do
          duck.hatch(demons[math.random(1, #demons)])
        end
      end, { desc = "Spawn horda" })

      -- Controle
      vim.keymap.set("n", "<leader>dc", function() duck.cook() end, { desc = "Matar ultimo" })
      vim.keymap.set("n", "<leader>dk", function() duck.cook_all() end, { desc = "Matar todos" })
    end,
  },
}
