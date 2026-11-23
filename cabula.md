# Cábula do Neovim

`<Espaço>` sozinho abre o menu (which-key). `<Espaço>?` abre esta cábula. `<Espaço>sk` procura em todos os atalhos.

## Essenciais

| Teclas | O quê |
|---|---|
| `<Espaço><Espaço>` | Buffers abertos |
| `<Espaço>sf` | Procurar ficheiros |
| `<Espaço>sg` | Procurar texto no projeto (grep) |
| `<Espaço>/` | Procurar no ficheiro atual |
| `<Espaço>f` | Formatar o ficheiro |
| `<Espaço>w` | Fechar buffer |
| `<Espaço>u` | Histórico de alterações (undotree) |
| `<Espaço>z` | Modo foco |
| `<Espaço>m` | Mason (instalar ferramentas) |
| `<Ctrl-s>` | Gravar |
| `<Ctrl-z>` | Desfazer |
| `<Ctrl-e>` / `<Ctrl-b>` | Explorador de ficheiros (Neo-tree) |
| `<Ctrl-t>` | Terminal flutuante |
| `<Esc><Esc>` | Sair do modo terminal |

## Ficheiros e pastas (`<Espaço>n`)

| Teclas | O quê |
|---|---|
| `nf` | Novo ficheiro (cria as pastas que faltarem) |
| `nd` | Nova pasta |
| `nr` | Renomear o ficheiro aberto |
| `nx` | Apagar o ficheiro aberto (pede confirmação) |
| `ny` | Copiar o caminho do ficheiro |
| `ne` | Mostrar o ficheiro no explorador |

Dentro do explorador (Neo-tree, `<Ctrl-e>`/`<Ctrl-b>`):

| Tecla | O quê |
|---|---|
| `a` | Novo ficheiro (acaba em `/` para criar pasta) |
| `A` | Nova pasta |
| `r` | Renomear |
| `d` | Apagar |
| `m` / `c` | Mover / copiar para outro sítio |
| `y` / `x` / `p` | Copiar / cortar / colar |
| `<Enter>` / `<Espaço>` | Abrir / expandir |
| `H` / `?` | Mostrar ficheiros escondidos / ajuda |
| `q` | Fechar |

## Janelas

| Teclas | O quê |
|---|---|
| `<Espaço>\` / `<Espaço>-` | Dividir na vertical / horizontal |
| `<Ctrl-h/j/k/l>` | Mudar de janela |
| `<Espaço>v` | Seleção em bloco |

## Saltar no texto (Flash)

| Teclas | O quê |
|---|---|
| `s` | Saltar para qualquer sítio visível |
| `S` | Selecionar um bloco (Treesitter) |
| `]t` / `[t` | TODO seguinte / anterior |

## Código (LSP)

| Teclas | O quê |
|---|---|
| `gd` / `gr` / `gI` / `gD` | Definição / referências / implementação / declaração |
| `K` | Documentação do que está debaixo do cursor |
| `<Espaço>ca` | Ações de código |
| `<Espaço>cr` | Renomear |
| `<Espaço>ct` | Ir para o tipo |
| `<Espaço>cs` / `<Espaço>cS` | Trocar argumento com o seguinte / anterior |
| `<Espaço>so` / `<Espaço>sO` | Símbolos do ficheiro / do projeto |
| `<Espaço>sd` | Diagnósticos |
| `<Espaço>q` | Lista de diagnósticos |
| `<Espaço>th` | Dicas inline (inlay hints) |

## Procurar (`<Espaço>s`)

| Teclas | O quê |
|---|---|
| `sf` / `sg` / `sw` | Ficheiros / texto / palavra debaixo do cursor |
| `s.` / `sr` | Ficheiros recentes / retomar a última pesquisa |
| `s/` | Procurar nos ficheiros abertos |
| `sh` / `sk` | Ajuda do Neovim / todos os atalhos |
| `st` / `sn` / `ss` | TODOs / configuração do Neovim / pesquisas do Telescope |

## Substituir (`<Espaço>S`)

| Teclas | O quê |
|---|---|
| `SS` | Procurar e substituir no projeto |
| `Sw` / `Sf` | Substituir a palavra / neste ficheiro |

## Marcas (`<Espaço>a`, Harpoon)

| Teclas | O quê |
|---|---|
| `aa` / `ar` | Marcar / desmarcar ficheiro |
| `am` | Menu das marcas |
| `<Espaço>1` … `<Espaço>5` | Ir para a marca 1 a 5 |

## Java / Spring (`<Espaço>j`, só em ficheiros Java)

| Teclas | O quê |
|---|---|
| `jo` | Organizar imports |
| `jv` / `jc` / `jm` | Extrair variável / constante / método (em seleção) |
| `jt` / `jT` | Correr o teste mais próximo / os testes da classe |
| `jr` | Arrancar a app (`./gradlew bootRun`) |
| `jg` / `jb` | Gradle: todos os testes / build |
| `ju` | Recarregar o projeto (depois de mudar o `build.gradle.kts`) |

## Debug (`<Espaço>b`)

| Teclas | O quê |
|---|---|
| `F5` | Arrancar / continuar |
| `F10` / `F11` / `F12` | Passo por cima / para dentro / para fora |
| `bb` / `bc` | Breakpoint / breakpoint condicional |
| `bu` / `bq` | Painel do debug / terminar |

## Sessões (`<Espaço>p`)

| Teclas | O quê |
|---|---|
| `ps` / `pl` | Restaurar a sessão desta pasta / a última |
| `pS` / `pd` | Escolher sessão / não gravar esta |

## Problemas e TODOs (`<Espaço>x`)

| Teclas | O quê |
|---|---|
| `xq` / `xl` / `xt` | TODOs na quickfix / location list / Trouble |

## Temas e opções (`<Espaço>t`)

| Teclas | O quê |
|---|---|
| `tm` | Midnight (o tema por omissão) |
| `tt` / `tc` | Tokyo Night / Cyberdream |

## Cosmética

| Teclas | O quê |
|---|---|
| `em` / `eg` | Chuva de código / jogo da vida |
| `eo` / `ed` | Donut 3D / trocar o tema do Drop |
| `er` / `es` | Parênteses coloridos / barra de scroll |
| `El` / `Er` / `Eg` | Glitch à esquerda / direita / nos dois lados |
| `Ek` / `Ej` | Terminal hacker à direita / esquerda |
| `Ee` / `Eo` / `Ea` | Monitor EKG / osciloscópio / modo hacker |
| `Pd` / `Ph` | Demónio aleatório / horda |
| `Pa` `Pb` `P1`…`P5` | Caveira, morcego, demónio, alien, dragão, fogo, robô |
| `Pc` / `Pk` | Matar o último / matar todos |
