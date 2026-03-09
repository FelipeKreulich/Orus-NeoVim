# Orus NeoVim

A modern, feature-rich Neovim configuration built on top of [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with a carefully curated set of plugins for an efficient development workflow.

## Requirements

- **Neovim** >= 0.11
- **Git** >= 2.19
- A [Nerd Font](https://www.nerdfonts.com/) (JetBrainsMono NF recommended)
- **ripgrep** (`rg`) for Telescope grep
- **make** and a C compiler for Treesitter and LuaSnip

## Features

- **Lazy plugin management** with [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP** with Mason for automatic language server installation
- **Autocompletion** with nvim-cmp + LuaSnip + friendly-snippets
- **Fuzzy finding** with Telescope
- **File explorer** with Neo-tree
- **Git integration** with Gitsigns and git-conflict
- **Fast navigation** with Flash and Harpoon
- **Beautiful UI** with Tokyonight theme, Barbar tabs, Noice, and Dressing
- **Code intelligence** with Treesitter, textobjects, and UFO folds
- **Smooth scrolling** with Neoscroll
- **Search & replace** across project with Spectre
- **Session management** with Persistence
- **Inline colors** with Colorizer
- **Focus mode** with Zen Mode
- **Discord presence** with Cord

## Plugin List

| Plugin | Description |
|--------|-------------|
| **tokyonight.nvim** | Dark colorscheme with vibrant colors |
| **neo-tree.nvim** | File explorer sidebar |
| **telescope.nvim** | Fuzzy finder for files, grep, symbols |
| **nvim-treesitter** | Syntax highlighting and code parsing |
| **treesitter-textobjects** | Smart text objects (functions, classes, args) |
| **nvim-lspconfig** | LSP configuration |
| **mason.nvim** | LSP/formatter/linter installer |
| **nvim-cmp** | Autocompletion engine |
| **LuaSnip** | Snippet engine |
| **friendly-snippets** | Premade snippets for many languages |
| **conform.nvim** | Code formatting |
| **flash.nvim** | Fast navigation / jump anywhere |
| **harpoon** | Quick file bookmarks |
| **barbar.nvim** | Buffer tabs |
| **gitsigns.nvim** | Git signs in gutter |
| **git-conflict.nvim** | Git conflict resolution |
| **nvim-spectre** | Project-wide search & replace |
| **persistence.nvim** | Session management |
| **undotree** | Undo history visualizer |
| **trouble.nvim** | Diagnostics panel |
| **error-lens.nvim** | Inline diagnostics |
| **todo-comments.nvim** | Highlight and search TODOs |
| **which-key.nvim** | Keybinding hints |
| **noice.nvim** | Modern UI for messages and cmdline |
| **dressing.nvim** | Improved input/select UI |
| **nvim-colorizer** | Inline color preview |
| **neoscroll.nvim** | Smooth scrolling |
| **nvim-ufo** | Modern code folding |
| **zen-mode.nvim** | Distraction-free writing |
| **toggleterm.nvim** | Floating terminal |
| **mini.nvim** | AI textobjects, surround, statusline |
| **nvim-surround** | Add/change/delete surroundings |
| **Comment.nvim** | Toggle comments |
| **nvim-autopairs** | Auto close brackets/quotes |
| **indent-blankline** | Colorful indent guides |
| **cord.nvim** | Discord Rich Presence |

## Keybindings

Leader key is `<Space>`.

### General

| Key | Action |
|-----|--------|
| `Ctrl+s` | Save file |
| `Ctrl+z` | Undo |
| `Ctrl+t` | Toggle floating terminal |
| `<leader>z` | Zen Mode |
| `<leader>\` | Vertical split |
| `<leader>-` | Horizontal split |
| `Ctrl+h/j/k/l` | Navigate between windows |

### Telescope (Search)

| Key | Action |
|-----|--------|
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search word under cursor |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>sd` | Search diagnostics |
| `<leader>st` | Search TODOs |
| `<leader>s.` | Recent files |
| `<leader>/` | Fuzzy search in buffer |
| `<leader><Space>` | List open buffers |

### Navigation

| Key | Action |
|-----|--------|
| `s` | Flash jump |
| `S` | Flash treesitter select |
| `<leader>H` | Add file to Harpoon |
| `<leader>h` | Harpoon quick menu |
| `<leader>1-5` | Jump to Harpoon file 1-5 |
| `Ctrl+b` | Toggle Neo-tree |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |
| `<leader>m` | Open Mason |

### Text Objects (Treesitter)

| Key | Action |
|-----|--------|
| `af` / `if` | Select function (outer/inner) |
| `ac` / `ic` | Select class (outer/inner) |
| `aa` / `ia` | Select argument (outer/inner) |
| `]f` / `[f` | Next/Previous function |
| `]c` / `[c` | Next/Previous class |
| `<leader>a` / `<leader>A` | Swap argument next/prev |

### Tools

| Key | Action |
|-----|--------|
| `<leader>S` | Spectre search & replace |
| `<leader>u` | Toggle Undotree |
| `<leader>qs` | Restore session |
| `<leader>ql` | Restore last session |
| `gcc` | Toggle comment line |
| `zR` / `zM` | Open/Close all folds |

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/FelipeKreulich/Orus-NeoVim.git ~/.config/nvim

# Open Neovim - plugins install automatically
nvim
```

## Structure

```
~/.config/nvim/
├── init.lua                          # Main config (options, keymaps, lazy.nvim bootstrap)
└── lua/
    └── plugins/
        ├── Autocomplete.lua          # nvim-cmp, LuaSnip, friendly-snippets
        ├── Autoformater.lua          # conform.nvim
        ├── CodeUtility.lua           # surround, comment, autopairs
        ├── FocusMode.lua             # zen-mode
        ├── Telescope.lua             # telescope + extensions
        ├── Treesitter.lua            # treesitter config
        ├── UIComponents.lua          # theme, neo-tree, barbar, trouble, cord
        ├── colorizer.lua             # inline color preview
        ├── dressing.lua              # improved UI
        ├── flash.lua                 # fast navigation
        ├── gitutils.lua              # git-conflict
        ├── harpoon.lua               # file bookmarks
        ├── indent.lua                # indent guides
        ├── lsp.lua                   # LSP + Mason
        ├── meme.lua                  # noice, neoscroll, ufo
        ├── persistence.lua           # session management
        ├── spectre.lua               # search & replace
        ├── terminal.lua              # toggleterm
        ├── treesitter-textobjects.lua # smart text objects
        ├── trouble-nvim.lua          # error-lens
        ├── undotree.lua              # undo history
        └── which-key.lua             # keybinding hints
```
