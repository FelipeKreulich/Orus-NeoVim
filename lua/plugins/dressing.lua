return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "Input:",
      border = "rounded",
    },
    select = {
      enabled = true,
      backend = { "telescope", "builtin" },
    },
  },
}
