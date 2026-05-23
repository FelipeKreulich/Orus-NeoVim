return {
  -- Preto absoluto (#000000) — o mais escuro que existe
  {
    "dasupradyumna/midnight.nvim",
    lazy = true,
    priority = 900,
  },

  -- Dark cyberpunk com neons sobre fundo muito escuro
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 900,
    opts = {
      italic_comments = true,
      hide_fillchars = false,
      borderless_telescope = true,
      terminal_colors = true,
    },
  },
}
