# Neovim cheatsheet

`<Space>` alone opens the menu (which-key). `<Space>?` opens this cheatsheet. `<Space>sk` searches every keymap. `<Space>ti` switches the language (Português / English).

## Essentials

| Keys | What |
|---|---|
| `<Space><Space>` | Open buffers |
| `<Space>sf` | Find files |
| `<Space>sg` | Search text in project (grep) |
| `<Space>/` | Search in current file |
| `<Space>f` | Format file |
| `<Space>w` | Close buffer |
| `<Space>u` | Undo history (undotree) |
| `<Space>z` | Focus mode |
| `<Space>m` | Mason (install tools) |
| `<Ctrl-s>` | Save |
| `<Ctrl-z>` | Undo |
| `<Ctrl-e>` / `<Ctrl-b>` | File explorer (Neo-tree) |
| `<Ctrl-t>` | Floating terminal |
| `<Esc><Esc>` | Exit terminal mode |

## Files and folders (`<Space>n`)

| Keys | What |
|---|---|
| `nf` | New file (creates missing folders) |
| `nd` | New folder |
| `nr` | Rename the open file |
| `nx` | Delete the open file (asks first) |
| `ny` | Copy the file path |
| `ne` | Reveal the file in the explorer |

Inside the explorer (Neo-tree, `<Ctrl-e>`/`<Ctrl-b>`):

| Key | What |
|---|---|
| `a` | New file (end with `/` for a folder) |
| `A` | New folder |
| `r` | Rename |
| `d` | Delete |
| `m` / `c` | Move / copy elsewhere |
| `y` / `x` / `p` | Copy / cut / paste |
| `<Enter>` / `<Space>` | Open / expand |
| `H` / `?` | Show hidden files / help |
| `q` | Close |

## Windows

| Keys | What |
|---|---|
| `<Space>\` / `<Space>-` | Split vertically / horizontally |
| `<Ctrl-h/j/k/l>` | Move between windows |
| `<Space>v` | Block selection |

## Jumping around (Flash)

| Keys | What |
|---|---|
| `s` | Jump anywhere on screen |
| `S` | Select a block (Treesitter) |
| `]t` / `[t` | Next / previous TODO |

## Vim commands (`g`, `z`, `[`, `]`)

Press just the first key and the menu shows the rest. The most useful:

| Keys | What |
|---|---|
| `gg` / `G` | First / last line |
| `gf` / `gx` | Open the file / link under the cursor |
| `gi` / `gv` | Back to last insert / last selection |
| `gu` / `gU` / `g~` | Lowercase / uppercase / toggle (plus a motion, e.g. `gUw`) |
| `gcc` / `gc` | Comment the line / the selection |
| `za` / `zR` / `zM` | Toggle fold / open all / close all |
| `zz` / `zt` / `zb` | Current line to center / top / bottom |
| `z=` | Spelling suggestions |
| `]d` / `[d` | Next / previous diagnostic |
| `<Ctrl-w>` | Window menu (split, move, resize) |
| `'` / `` ` `` | Jump to a mark |
| `"` | Pick a register (copy/paste) |

## Code (LSP)

| Keys | What |
|---|---|
| `gd` / `gr` / `gI` / `gD` | Definition / references / implementation / declaration |
| `K` | Documentation for what is under the cursor |
| `<Space>ca` | Code actions |
| `<Space>cr` | Rename |
| `<Space>ct` | Go to type |
| `<Space>cs` / `<Space>cS` | Swap argument with next / previous |
| `<Space>so` / `<Space>sO` | File / project symbols |
| `<Space>sd` | Diagnostics |
| `<Space>q` | Diagnostics list |
| `<Space>th` | Inlay hints |

## Search (`<Space>s`)

| Keys | What |
|---|---|
| `sf` / `sg` / `sw` | Files / text / word under cursor |
| `s.` / `sr` | Recent files / resume last search |
| `s/` | Search in open files |
| `sh` / `sk` | Neovim help / all keymaps |
| `st` / `sn` / `ss` | TODOs / Neovim config / Telescope pickers |

## Replace (`<Space>S`)

| Keys | What |
|---|---|
| `SS` | Search and replace in project |
| `Sw` / `Sf` | Replace word / in this file |

## Marks (`<Space>a`, Harpoon)

| Keys | What |
|---|---|
| `aa` / `ar` | Mark / unmark file |
| `am` | Marks menu |
| `<Space>1` … `<Space>5` | Go to mark 1 to 5 |

## Java / Spring (`<Space>j`, Java files only)

| Keys | What |
|---|---|
| `jo` | Organize imports |
| `jv` / `jc` / `jm` | Extract variable / constant / method (in selection) |
| `jt` / `jT` | Run nearest test / class tests |
| `jr` | Run the app (`./gradlew bootRun`) |
| `jg` / `jb` | Gradle: all tests / build |
| `ju` | Reload project (after changing `build.gradle.kts`) |

## Debug (`<Space>b`)

| Keys | What |
|---|---|
| `F5` | Start / continue |
| `F10` / `F11` / `F12` | Step over / into / out |
| `bb` / `bc` | Breakpoint / conditional breakpoint |
| `bu` / `bq` | Debug panel / stop |

## Sessions (`<Space>p`)

| Keys | What |
|---|---|
| `ps` / `pl` | Restore this folder's session / the last one |
| `pS` / `pd` | Pick a session / don't save this one |

## Problems and TODOs (`<Space>x`)

| Keys | What |
|---|---|
| `xq` / `xl` / `xt` | TODOs in quickfix / location list / Trouble |

## Themes and options (`<Space>t`)

| Keys | What |
|---|---|
| `tm` | Midnight (default theme) |
| `tt` / `tc` | Tokyo Night / Cyberdream |
| `ti` | Language: Português / English (also `:Idioma pt` or `:Idioma en`) |

## Eye candy

| Keys | What |
|---|---|
| `em` / `eg` | Code rain / game of life |
| `eo` / `ed` | 3D donut / cycle Drop theme |
| `er` / `es` | Rainbow brackets / scrollbar |
| `El` / `Er` / `Eg` | Glitch left / right / both sides |
| `Ek` / `Ej` | Hacker terminal right / left |
| `Ee` / `Eo` / `Ea` | EKG monitor / oscilloscope / hacker mode |
| `Pd` / `Ph` | Random demon / horde |
| `Pa` `Pb` `P1`…`P5` | Skull, bat, demon, alien, dragon, fire, robot |
| `Pc` / `Pk` | Kill the last one / kill them all |
