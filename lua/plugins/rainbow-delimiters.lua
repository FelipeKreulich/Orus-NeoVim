return {
  "HiPhish/rainbow-delimiters.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local rainbow = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow.strategy["global"],
        vim = rainbow.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    }

    local enabled = true
    vim.keymap.set("n", "<leader>er", function()
      if enabled then
        vim.cmd("RainbowDelimitersDisable")
      else
        vim.cmd("RainbowDelimitersEnable")
      end
      enabled = not enabled
      vim.notify("Rainbow Delimiters: " .. (enabled and "ON" or "OFF"))
    end, { desc = "Toggle Rainbow Delimiters" })
  end,
}
