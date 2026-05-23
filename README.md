# Orus NeoVim

A modern, feature-rich Neovim configuration built on top of [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with a carefully curated set of plugins for an efficient development workflow — plus visual effects, hacker aesthetics, and a spinning 3D donut.

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
- **Beautiful UI** with theme switcher (Tokyo Night / Midnight / Cyberdream), Barbar tabs, Noice, and Dressing
- **Code intelligence** with Treesitter, textobjects, and UFO folds
- **Smooth scrolling** with Neoscroll
- **Search & replace** across project with Spectre
- **Session management** with Persistence
- **Inline colors** with Colorizer and Rainbow Delimiters
- **Focus mode** with Zen Mode
- **Discord presence** with Cord
- **Visual effects** — cellular automaton, drop screensaver, satellite scrollbar, 3D ASCII donut
- **Hacker aesthetic** — glitch sidebars, matrix rain, fake terminal logs, EKG monitor, oscilloscope
- **Duck pets** — spawn animated demons, skulls, bats, and dragons on your editor
- **Live coding** with TidalCycles integration

## Plugin List

### Core / LSP / Editing

| Plugin | Description |
|--------|-------------|
| **nvim-lspconfig** | LSP configuration |
| **mason.nvim** | LSP/formatter/linter installer |
| **nvim-cmp** | Autocompletion engine |
| **LuaSnip** | Snippet engine |
| **friendly-snippets** | Premade snippets for many languages |
| **conform.nvim** | Code formatting |
| **nvim-treesitter** | Syntax highlighting and code parsing |
| **treesitter-textobjects** | Smart text objects (functions, classes, args) |
| **rainbow-delimiters.nvim** | Colorized nested delimiters by depth |
| **mini.nvim** | AI textobjects, surround, statusline |
| **Comment.nvim** | Toggle comments |
| **nvim-autopairs** | Auto close brackets/quotes |
| **nvim-ufo** | Modern code folding |
| **undotree** | Undo history visualizer |

### Navigation

| Plugin | Description |
|--------|-------------|
| **telescope.nvim** | Fuzzy finder for files, grep, symbols |
| **flash.nvim** | Jump anywhere instantly |
| **harpoon** | Quick file bookmarks |
| **neo-tree.nvim** | File explorer sidebar |
| **nvim-spectre** | Project-wide search & replace |

### UI / Themes

| Plugin | Description |
|--------|-------------|
| **tokyonight.nvim** | Dark colorscheme (default) |
| **midnight.nvim** | Pure black (#000000) colorscheme |
| **cyberdream.nvim** | Dark cyberpunk colorscheme with neons |
| **oxocarbon.nvim** | IBM Oxocarbon dark colorscheme |
| **barbar.nvim** | Buffer tabs |
| **noice.nvim** | Modern UI for messages and cmdline |
| **dressing.nvim** | Improved input/select UI |
| **nvim-colorizer** | Inline color preview |
| **indent-blankline** | Colorful indent guides |
| **satellite.nvim** | Decorated scrollbar with diagnostics and git |
| **neoscroll.nvim** | Smooth scrolling |
| **reactive.nvim** | Cursor color changes per mode |
| **alpha-nvim** | Startup dashboard |

### Git

| Plugin | Description |
|--------|-------------|
| **gitsigns.nvim** | Git signs in gutter |
| **git-conflict.nvim** | Git conflict resolution |

### Tools / Diagnostics

| Plugin | Description |
|--------|-------------|
| **trouble.nvim** | Diagnostics panel |
| **error-lens.nvim** | Inline diagnostics |
| **todo-comments.nvim** | Highlight and search TODOs |
| **which-key.nvim** | Keybinding hints |
| **persistence.nvim** | Session management |
| **toggleterm.nvim** | Floating terminal |
| **zen-mode.nvim** | Distraction-free writing |
| **cord.nvim** | Discord Rich Presence |

### Visual Effects & Fun

| Plugin | Description |
|--------|-------------|
| **cellular-automaton.nvim** | Animate buffer as Game of Life or make it rain |
| **drop.nvim** | Snow/stars/leaves falling screensaver |
| **duck.nvim** | Animated pets (demons, skulls, bats, dragons) |
| **glitch-sidebar** *(custom)* | Glitch art + matrix rain sidebars |
| **hacker-panels** *(custom)* | Fake hacker terminal, EKG monitor, oscilloscope |
| **donut** *(custom)* | 3D ASCII spinning donut in a floating window |

### Live Coding

| Plugin | Description |
|--------|-------------|
| **vim-tidal** | TidalCycles live coding integration |

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

### Themes

| Key | Action |
|-----|--------|
| `<leader>tt` | Tokyo Night (default) |
| `<leader>tm` | Midnight (pure black) |
| `<leader>tc` | Cyberdream (cyberpunk neons) |

### Visual Effects `<leader>e`

| Key | Action |
|-----|--------|
| `<leader>em` | Cellular Automaton — Make it Rain |
| `<leader>eg` | Cellular Automaton — Game of Life |
| `<leader>ed` | Cycle Drop theme (snow/stars/leaves/xmas/spring) |
| `<leader>es` | Toggle Satellite scrollbar |
| `<leader>er` | Toggle Rainbow Delimiters |
| `<leader>eo` | Toggle 3D ASCII Donut |

### Duck Pets `<leader>d`

| Key | Action |
|-----|--------|
| `<leader>dd` | Spawn random demon |
| `<leader>da` | Spawn skull |
| `<leader>db` | Spawn bat |
| `<leader>d1` | Spawn demon |
| `<leader>d2` | Spawn alien |
| `<leader>d3` | Spawn dragon |
| `<leader>d4` | Spawn fire |
| `<leader>d5` | Spawn robot |
| `<leader>dh` | Spawn horde (5 at once) |
| `<leader>dc` | Kill last pet |
| `<leader>dk` | Kill all pets |

### Glitch Sidebar `<leader>g`

| Key | Action |
|-----|--------|
| `<leader>gg` | Toggle both sides |
| `<leader>gl` | Toggle left (glitch chaos) |
| `<leader>gr` | Toggle right (matrix rain) |

### Hacker Panels `<leader>h`

| Key | Action |
|-----|--------|
| `<leader>hh` | Hacker terminal (right) |
| `<leader>hl` | Hacker terminal (left) |
| `<leader>he` | EKG heartbeat monitor (right) |
| `<leader>ho` | Oscilloscope (left) |
| `<leader>ha` | Combo: oscilloscope + hacker terminal |

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

# Open Neovim — plugins install automatically
nvim
```

## Structure

```
~/.config/nvim/
├── init.lua                              # Main config (options, keymaps, lazy.nvim bootstrap)
└── lua/
    └── plugins/
        ├── Autocomplete.lua              # nvim-cmp, LuaSnip, friendly-snippets
        ├── Autoformater.lua              # conform.nvim
        ├── CodeUtility.lua               # surround, comment, autopairs
        ├── FocusMode.lua                 # zen-mode
        ├── Telescope.lua                 # telescope + extensions
        ├── Treesitter.lua                # treesitter + parsers
        ├── UIComponents.lua              # themes, neo-tree, barbar, trouble, cord
        ├── cellular-automaton.lua        # make it rain / game of life
        ├── colorizer.lua                 # inline color preview
        ├── donut.lua                     # 3D ASCII spinning donut (custom)
        ├── dressing.lua                  # improved UI
        ├── drop.lua                      # falling snow/stars screensaver
        ├── flash.lua                     # fast navigation
        ├── gitutils.lua                  # git-conflict
        ├── glitch-sidebar.lua            # glitch art + matrix rain (custom)
        ├── hacker-panels.lua             # hacker terminal, EKG, oscilloscope (custom)
        ├── harpoon.lua                   # file bookmarks
        ├── indent.lua                    # indent guides
        ├── lsp.lua                       # LSP + Mason
        ├── meme.lua                      # noice, neoscroll, ufo
        ├── persistence.lua               # session management
        ├── pets.lua                      # duck.nvim animated pets/demons
        ├── rainbow-delimiters.lua        # colorized nested delimiters
        ├── reactive.lua                  # cursor color per mode
        ├── satellite.lua                 # decorated scrollbar
        ├── spectre.lua                   # search & replace
        ├── terminal.lua                  # toggleterm
        ├── themes.lua                    # midnight + cyberdream themes
        ├── tidal.lua                     # TidalCycles live coding
        ├── treesitter-textobjects.lua    # smart text objects
        ├── trouble-nvim.lua              # error-lens + trouble
        ├── undotree.lua                  # undo history
        └── which-key.lua                 # keybinding hints
```
