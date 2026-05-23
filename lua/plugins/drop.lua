return {
  "folke/drop.nvim",
  event = "VimEnter",
  config = function()
    local themes = { "snow", "stars", "leaves", "xmas", "spring" }
    local idx = 1

    require("drop").setup({
      theme = themes[idx],
      max = 40,
      interval = 150,
      screensaver = 1000 * 60 * 10, -- aparece após 10 min idle
      filetypes = { "dashboard" },
    })

    vim.keymap.set("n", "<leader>ed", function()
      idx = (idx % #themes) + 1
      require("drop").setup({ theme = themes[idx] })
      vim.notify("Drop theme: " .. themes[idx], vim.log.levels.INFO)
    end, { desc = "Cycle Drop theme" })
  end,
}
