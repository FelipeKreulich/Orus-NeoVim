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

    vim.keymap.set("n", "<leader>er", function()
      rainbow.toggle(0)
      local t = require("config.idioma").t
      vim.notify(t("Parênteses coloridos: ", "Rainbow brackets: ") .. (rainbow.is_enabled(0) and t("ligados", "on") or t("desligados", "off")))
    end, { desc = "Parênteses coloridos" })
  end,
}
