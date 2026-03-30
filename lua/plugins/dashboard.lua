return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[          .                                                      .          ]],
        [[        .n                   .                 .                  n.        ]],
        [[  .   .dP                  dP                   9b                 9b.    . ]],
        [[ 4    qXb         .       dX                     Xb       .        dXp     t]],
        [[dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb]],
        [[9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP]],
        [[ 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP ]],
        [[  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'  ]],
        [[    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'    ]],
        [[        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~        ]],
        [[                        )b.  .dbo.dP'`v'`9b.odb.  .dX(                      ]],
        [[                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.                    ]],
        [[                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb                   ]],
        [[                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb                  ]],
        [[                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP                  ]],
        [[                     `'      9XXXXXX(   )XXXXXXP      `'                    ]],
        [[                              XXXX X.`v'.X XXXX                             ]],
        [[                              XP^X'`b   d'`X^XX                             ]],
        [[                              X. 9  `   '  P )X                             ]],
        [[                              `b  `       '  d'                             ]],
        [[                               `             '                              ]],
      }

      dashboard.section.header.opts.hl = "AlphaHeader"

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("g", "  Grep text", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("t", "  Tidal session", "<cmd>edit ~/Projetos/tracks/teste.tidal<cr>"),
        dashboard.button("c", "  Config", "<cmd>edit ~/.config/nvim/init.lua<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
      }

      dashboard.section.footer.val = "⟨ ORUS ⟩ — live coding hard techno"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Cores
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#ff0040" })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#555555", italic = true })

      alpha.setup(dashboard.opts)

      -- Desabilita statusline no dashboard
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.opt_local.laststatus = 0
          vim.opt_local.showtabline = 0
        end,
      })
    end,
  },
}
