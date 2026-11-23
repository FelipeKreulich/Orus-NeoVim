<div align="center">

```
 ██████╗ ██████╗ ██╗   ██╗███████╗
██╔═══██╗██╔══██╗██║   ██║██╔════╝
██║   ██║██████╔╝██║   ██║███████╗
██║   ██║██╔══██╗██║   ██║╚════██║
╚██████╔╝██║  ██║╚██████╔╝███████║
 ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝
```

### A fast, bilingual Neovim setup for real work, with a hacker soul

[![Neovim](https://img.shields.io/badge/Neovim-0.12%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org)
[![lazy.nvim](https://img.shields.io/badge/lazy.nvim-plugin%20manager-7E56C2?style=for-the-badge)](https://github.com/folke/lazy.nvim)
[![Java](https://img.shields.io/badge/Java%20%2B%20Spring%20Boot-ready-F80000?style=for-the-badge&logo=openjdk&logoColor=white)](#-java--spring-boot)
[![i18n](https://img.shields.io/badge/UI-Português%20%7C%20English-0A84FF?style=for-the-badge)](#-language-português--english)

[Features](#-features) ·
[Install](#-installation) ·
[Keymaps](#%EF%B8%8F-keymaps) ·
[Java](#-java--spring-boot) ·
[Language](#-language-português--english) ·
[Eye candy](#%EF%B8%8F-eye-candy) ·
[Structure](#%EF%B8%8F-structure)

</div>

---

Built on top of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and grown into a daily driver: a curated set of plugins for an efficient workflow, first-class Java and Spring Boot support, a menu that teaches you every keymap, and a few visual effects for fun.

## ✨ Features

- 🧭 **Discoverable by design**: press `<Space>` and a tidy menu shows every keymap, grouped by what it does. Press `<Space>?` for a full cheatsheet in a floating window.
- 🌍 **Bilingual UI**: every keymap description is in **Portuguese by default**, with **English** one keystroke away (`<Space>ti`). That includes Neovim's built-in `g`, `z`, `[`, `]`, marks, registers and window menus.
- ☕ **Java & Spring Boot out of the box**: jdtls, the Spring Boot language server, JUnit runner, debugger and Gradle tasks, all wired up.
- 🧠 **LSP everywhere**: Mason installs servers and tools automatically; completion with nvim-cmp and LuaSnip; formatting on save with conform.
- 🔎 **Find anything**: Telescope for files, text, symbols and diagnostics; Flash to jump anywhere; Harpoon for your favourite files; Spectre for project-wide replace.
- 📁 **File management without leaving the buffer**: create, rename, move and delete files and folders from `<Space>n` or the Neo-tree explorer.
- 🎨 **Midnight by default**: a pure black theme, with Tokyo Night and Cyberdream one keystroke away.
- 🕹️ **Eye candy**: code rain, game of life, a spinning 3D donut, glitch sidebars, hacker terminals, an EKG monitor and animated pets.

## 📦 Requirements

| Tool | Why |
|---|---|
| **Neovim ≥ 0.12** | Uses the new `vim.lsp.enable` API |
| **Git ≥ 2.19** | Plugin installation |
| **A [Nerd Font](https://www.nerdfonts.com/)** | Icons (JetBrainsMono Nerd Font recommended) |
| **ripgrep** (`rg`) | Telescope text search |
| **make** + a C compiler | Treesitter parsers and LuaSnip |
| **JDK 21 and JDK 25** *(optional)* | Java support: `brew install openjdk@21 openjdk@25` |

## 🚀 Installation

```bash
# Back up your current config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/FelipeKreulich/Orus-NeoVim.git ~/.config/nvim

# Open Neovim: lazy.nvim installs the plugins and Mason installs the tools
nvim
```

The first start takes a minute while everything downloads. After that it starts instantly.

## ⌨️ Keymaps

The leader key is **`<Space>`**. You don't need to memorise anything: press `<Space>` (or `g`, `z`, `[`, `]`, `<C-w>`) and wait for the menu.

| Prefix | Group | Highlights |
|---|---|---|
| `<Space>s` | 🔍 Search | `sf` files · `sg` grep · `sw` word · `so` symbols · `sk` all keymaps |
| `<Space>c` | 💻 Code | `ca` code actions · `cr` rename · `ct` go to type |
| `<Space>n` | 📁 Files and folders | `nf` new file · `nd` new folder · `nr` rename · `nx` delete · `ne` reveal |
| `<Space>j` | ☕ Java / Spring | `jt` run test · `jr` bootRun · `jo` organize imports · `jm` extract method |
| `<Space>b` | 🐞 Debug | `bb` breakpoint · `bu` debug panel · `F5` `F10` `F11` `F12` |
| `<Space>a` | 📌 Marks (Harpoon) | `aa` mark file · `am` menu · `<Space>1`…`5` jump |
| `<Space>S` | 🔁 Replace (Spectre) | `SS` project · `Sw` word · `Sf` file |
| `<Space>p` | 💾 Sessions | `ps` restore · `pl` last session |
| `<Space>x` | ⚠️ Problems and TODOs | `xq` quickfix · `xt` Trouble |
| `<Space>t` | 🎨 Themes and options | `tm` Midnight · `tt` Tokyo Night · `tc` Cyberdream · `ti` language |
| `<Space>e` `E` `P` | 🕹️ Eye candy | effects · hacker screens · pets |

**Everyday keys**

| Key | Action |
|---|---|
| `<Space><Space>` | Open buffers |
| `<Space>/` | Search in current file |
| `<Space>f` | Format file |
| `<Space>w` | Close buffer |
| `<Space>?` | Cheatsheet with **every** keymap |
| `Ctrl-s` / `Ctrl-z` | Save / undo |
| `Ctrl-e` / `Ctrl-b` | File explorer |
| `Ctrl-t` | Floating terminal |
| `Ctrl-h/j/k/l` | Move between windows |
| `gd` / `gr` / `K` | Definition / references / docs |
| `s` / `S` | Flash jump / select a block |

The full list lives in [`cabula.en.md`](cabula.en.md) (English) and [`cabula.md`](cabula.md) (Portuguese), the same files `<Space>?` opens.

## ☕ Java & Spring Boot

Open any `.java` file in a Gradle or Maven project and you get:

- **jdtls**, started per project by [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) with its own workspace cache;
- the **Spring Boot language server** ([spring-boot.nvim](https://github.com/JavaHello/spring-boot.nvim)): completion and validation in `application.yaml`/`.properties`, beans and endpoints;
- a **JUnit** runner and a **debugger** (nvim-dap + dap-ui, with hot code replace);
- **Gradle** tasks in a floating terminal: `bootRun`, `test`, `build`.

> [!NOTE]
> Current jdtls releases need **Java 25** to run. The config looks for `openjdk@25` from Homebrew first and falls back to a JDK 25 that Gradle downloaded into `~/.gradle/jdks`.

## 🌍 Language: Português / English

The UI speaks **Portuguese by default**. Switch at any time:

```vim
<Space>ti        " toggle
:Idioma en       " English
:Idioma pt       " Português
```

The choice is saved and survives restarts. It covers the which-key menu (including Neovim's built-in keymaps and the plugins' ones), its footer, the cheatsheet and the config's own messages. Neovim's built-in error messages follow your Neovim build and usually stay in English.

To translate something new, add a line to [`lua/config/traducoes.lua`](lua/config/traducoes.lua):

```lua
["Text in English"] = "Texto em português",
```

## 🕹️ Eye candy

| Keys | What it does |
|---|---|
| `<Space>em` / `eg` | Make it rain / game of life with your code |
| `<Space>eo` | A spinning 3D ASCII donut |
| `<Space>ed` | Falling snow, stars or leaves |
| `<Space>El` / `Er` / `Eg` | Glitch art and matrix rain sidebars |
| `<Space>Ek` / `Ee` / `Eo` / `Ea` | Hacker terminal, EKG monitor, oscilloscope, full hacker mode |
| `<Space>Pd` / `Ph` / `Pk` | Spawn a demon, a horde, or kill them all |

## 🧩 Plugins

<details>
<summary><b>Show the full list</b></summary>

| Area | Plugins |
|---|---|
| Core | lazy.nvim, which-key.nvim, plenary.nvim, lazydev.nvim |
| LSP & tools | nvim-lspconfig, mason.nvim, mason-lspconfig, mason-tool-installer, conform.nvim |
| Java | nvim-jdtls, spring-boot.nvim, nvim-dap, nvim-dap-ui |
| Completion | nvim-cmp, LuaSnip, friendly-snippets |
| Syntax | nvim-treesitter, treesitter-textobjects, rainbow-delimiters, nvim-ufo |
| Editing | mini.nvim, Comment.nvim, nvim-autopairs, nvim-surround, undotree |
| Navigation | telescope.nvim, flash.nvim, harpoon, neo-tree.nvim, nvim-spectre |
| UI | midnight.nvim, tokyonight.nvim, cyberdream.nvim, barbar.nvim, noice.nvim, nvim-notify, dressing.nvim, indent-blankline, satellite.nvim, neoscroll.nvim, reactive.nvim, alpha-nvim, nvim-colorizer |
| Git | gitsigns.nvim, git-conflict.nvim |
| Workflow | trouble.nvim, error-lens.nvim, todo-comments.nvim, persistence.nvim, toggleterm.nvim, zen-mode.nvim, cord.nvim |
| Fun | cellular-automaton.nvim, drop.nvim, duck.nvim, vim-tidal, plus the custom donut, glitch-sidebar and hacker-panels |

</details>

## 🗂️ Structure

```
~/.config/nvim/
├── init.lua                 # Options, core keymaps, lazy.nvim bootstrap
├── cabula.md                # Cheatsheet (Português)
├── cabula.en.md             # Cheatsheet (English)
├── ftplugin/
│   └── java.lua             # jdtls per project: tests, debug, Spring, Gradle keymaps
└── lua/
    ├── config/
    │   ├── idioma.lua       # Language switch (PT / EN)
    │   ├── traducoes.lua    # EN ↔ PT dictionary for every keymap description
    │   ├── cabula.lua       # Floating cheatsheet (<Space>?)
    │   └── ficheiros.lua    # New / rename / delete files and folders (<Space>n)
    └── plugins/             # One file per plugin or area (lsp, java, telescope, themes…)
```

<div align="center">

Made with ☕ and Lua by [Felipe Kreulich](https://github.com/FelipeKreulich)

</div>
