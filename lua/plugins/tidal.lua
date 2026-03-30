return {
  {
    "tidalcycles/vim-tidal",
    lazy = false,
    init = function()
      vim.g.tidal_target = "terminal"
      vim.g.tidal_ghci = vim.fn.expand("~/.ghcup/bin/ghci")
      -- Registra filetype .tidal manualmente
      vim.filetype.add({ extension = { tidal = "tidal" } })
    end,
    config = function()
      -- Sobrescreve o <C-e> do neoscroll em buffers .tidal
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tidal",
        callback = function()
          vim.keymap.set("n", "<C-e>", "<Plug>TidalParagraphSend", { buffer = true, silent = true })
          vim.keymap.set("x", "<C-e>", "<Plug>TidalRegionSend", { buffer = true, silent = true })
          vim.keymap.set("i", "<C-e>", "<Esc><Plug>TidalParagraphSend<Esc>i<Right>", { buffer = true, silent = true })
        end,
      })
    end,
  },
}
