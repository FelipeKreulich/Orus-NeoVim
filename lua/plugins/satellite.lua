return {
  "lewis6991/satellite.nvim",
  config = function()
    require("satellite").setup({
      current_only = false,
      winblend = 50,
      zindex = 40,
      excluded_filetypes = { "neo-tree", "toggleterm", "alpha", "dashboard" },
      handlers = {
        cursor = { enable = true },
        diagnostic = {
          enable = true,
          signs = { "-", "=", "≡" },
        },
        gitsigns = { enable = true },
        marks = { enable = true },
        search = { enable = true },
      },
    })

    local enabled = true
    vim.keymap.set("n", "<leader>es", function()
      if enabled then
        vim.cmd("SatelliteDisable")
      else
        vim.cmd("SatelliteEnable")
      end
      enabled = not enabled
      vim.notify("Satellite: " .. (enabled and "ON" or "OFF"))
    end, { desc = "Toggle Satellite scrollbar" })
  end,
}
