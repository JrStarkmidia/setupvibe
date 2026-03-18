# Guia do Tmux

O SetupVibe instala e configura o tmux com o [TPM](https://github.com/tmux-plugins/tpm) e um conjunto curado de plugins. A configuração fica em [`tmux.conf`](../../conf/tmux.conf) e é baixada automaticamente durante o setup.

---

## O que é o tmux?

O tmux é um **multiplexador de terminal** — permite executar múltiplas sessões de terminal dentro de uma única janela, manter sessões ativas após desconexão e dividir a tela em painéis. Essencial para servidores remotos e usuários avançados.

**Conceitos principais:**

| Conceito | Descrição |
|---|---|
| **Session** | Uma coleção de janelas. Sobrevive à desconexão. |
| **Window** | Como uma aba do browser — uma visão em tela cheia dentro de uma sessão. |
| **Pane** | Uma divisão dentro de uma window. Múltiplos panes compartilham uma window. |
| **Prefix** | `Ctrl + b` — pressionado antes de todo keybind do tmux. |

---

## Primeiros Passos

```bash
# Iniciar uma nova sessão
tmux

# Iniciar uma sessão com nome
tmux new -s meuprojeto

# Listar sessões
tmux ls

# Conectar à última sessão
tmux attach

# Conectar a uma sessão pelo nome
tmux attach -t meuprojeto

# Encerrar uma sessão
tmux kill-session -t meuprojeto
```

Após abrir o tmux, pressione `prefix + I` (I maiúsculo) para instalar todos os plugins.

---

## Keybindings Padrão

> Todos os keybinds exigem pressionar **`Ctrl + b`** primeiro, depois a tecla.

### Sessões

| Keybind | Ação |
|---|---|
| `prefix + s` | Listar e alternar sessões (interativo) |
| `prefix + $` | Renomear sessão atual |
| `prefix + d` | Desconectar da sessão (sessão continua rodando) |
| `prefix + (` | Ir para a sessão anterior |
| `prefix + )` | Ir para a próxima sessão |
| `prefix + L` | Ir para a última sessão usada |

### Windows

| Keybind | Ação |
|---|---|
| `prefix + c` | Criar nova window |
| `prefix + ,` | Renomear window atual |
| `prefix + &` | Fechar window atual |
| `prefix + n` | Próxima window |
| `prefix + p` | Window anterior |
| `prefix + l` | Última window (alternar) |
| `prefix + w` | Listar e alternar windows (interativo) |
| `prefix + 0–9` | Ir para window pelo número |
| `prefix + '` | Prompt para número da window |
| `prefix + .` | Mover window para outro índice |
| `prefix + f` | Buscar window por nome |

### Panes

| Keybind | Ação |
|---|---|
| `prefix + %` | Dividir verticalmente (esquerda/direita) |
| `prefix + "` | Dividir horizontalmente (cima/baixo) |
| `prefix + o` | Rotacionar para o próximo pane |
| `prefix + ;` | Alternar para o último pane ativo |
| `prefix + x` | Fechar pane atual |
| `prefix + z` | Zoom/unzoom do pane (tela cheia) |
| `prefix + q` | Mostrar números dos panes (pressione o número para ir) |
| `prefix + {` | Trocar pane com o anterior |
| `prefix + }` | Trocar pane com o próximo |
| `prefix + Alt+1–5` | Layouts predefinidos de panes (even-h, even-v, main-h, main-v, tiled) |
| `prefix + !` | Transformar pane em window própria |
| `prefix + m` | Marcar pane |
| `prefix + M` | Desmarcar pane |
| `↑ ↓ ← →` | Navegar entre panes por direção |
| `prefix + Ctrl + ↑↓←→` | Redimensionar pane (1 célula) |
| `prefix + Alt + ↑↓←→` | Redimensionar pane (5 células) |

### Modo de Cópia

| Keybind | Ação |
|---|---|
| `prefix + [` | Entrar no modo de cópia |
| `prefix + ]` | Colar último buffer copiado |
| `prefix + #` | Listar buffers de colagem |
| `prefix + =` | Escolher buffer para colar da lista |
| `prefix + -` | Deletar buffer mais recente |
| `q` (no modo de cópia) | Sair do modo de cópia |
| `Space` (no modo de cópia) | Iniciar seleção |
| `Enter` (no modo de cópia) | Copiar seleção e sair |
| `/` (no modo de cópia) | Buscar para frente |
| `?` (no modo de cópia) | Buscar para trás |

### Diversos

| Keybind | Ação |
|---|---|
| `prefix + :` | Abrir prompt de comando do tmux |
| `prefix + ?` | Listar todos os keybindings |
| `prefix + r` | Recarregar config do tmux |
| `prefix + t` | Mostrar relógio |
| `prefix + i` | Mostrar informações da window |
| `prefix + ~` | Mostrar mensagens do tmux |
| `prefix + D` | Escolher cliente para desconectar |
| `prefix + E` | Distribuir panes igualmente |
| `prefix + Ctrl+z` | Suspender cliente tmux |

---

## Plugins

### Core

| Plugin | Descrição |
|---|---|
| [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) | Gerenciador de plugins |
| [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Defaults sensatos |

**Keybinds do TPM:**

| Keybind | Ação |
|---|---|
| `prefix + I` | Instalar plugins |
| `prefix + U` | Atualizar plugins |
| `prefix + Alt+u` | Remover plugins não utilizados |

---

### Navegação e Controle de Panes

#### [tmux-pain-control](https://github.com/tmux-plugins/tmux-pain-control)

Keybinds consistentes e intuitivos para dividir e redimensionar panes.

| Keybind | Ação | Substitui o padrão |
|---|---|---|
| `prefix + \|` | Dividir verticalmente (esquerda/direita) | `prefix + %` ainda funciona |
| `prefix + -` | Dividir horizontalmente (cima/baixo) | Substitui `delete-buffer` (raramente usado) |
| `prefix + \` | Dividir verticalmente em tela cheia | — |
| `prefix + _` | Dividir horizontalmente em tela cheia | — |
| `prefix + h` | Selecionar pane à esquerda | — |
| `prefix + j` | Selecionar pane abaixo | — |
| `prefix + k` | Selecionar pane acima | — |
| `prefix + l` | Selecionar pane à direita | `last-window` restaurado após carregar plugin |
| `prefix + H/J/K/L` | Redimensionar pane (5 células) | — |

#### [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

Navegue entre panes do tmux e splits do vim com as mesmas teclas.

| Keybind | Ação |
|---|---|
| `Ctrl + h` | Mover para esquerda |
| `Ctrl + j` | Mover para baixo |
| `Ctrl + k` | Mover para cima |
| `Ctrl + l` | Mover para direita |
| `Ctrl + \` | Mover para pane anterior |

> Sem prefix. Funciona de forma transparente dentro do vim/neovim.

---

### Mouse

#### [NHDaly/tmux-better-mouse-mode](https://github.com/NHDaly/tmux-better-mouse-mode)

Melhora o comportamento do mouse no tmux.

| Funcionalidade | Comportamento |
|---|---|
| Rolar para baixo no modo de cópia | Sai do modo de cópia automaticamente |
| Rolar sobre pane | Não muda o pane ativo |
| Rolar em vim/less/man | Envia eventos de scroll para o app (buffer alternativo) |

---

### Cópia e Clipboard

#### [tmux-plugins/tmux-yank](https://github.com/tmux-plugins/tmux-yank)

Copia texto para o clipboard do sistema.

| Keybind | Contexto | Ação |
|---|---|---|
| `prefix + y` | Normal | Copia texto na linha de comando |
| `prefix + Y` | Normal | Copia o diretório de trabalho atual |
| `y` | Modo de cópia | Copia seleção para o clipboard |
| `Y` | Modo de cópia | Copia seleção e cola na linha de comando |

#### [CrispyConductor/tmux-copy-toolkit](https://github.com/CrispyConductor/tmux-copy-toolkit)

Utilitários aprimorados de modo de cópia.

| Keybind | Ação |
|---|---|
| `prefix + e` | Ativar copy toolkit |

#### [abhinav/tmux-fastcopy](https://github.com/abhinav/tmux-fastcopy)

Cópia baseada em hints (estilo vimium). Destaca padrões de texto na tela e permite copiá-los digitando letras curtas.

| Keybind | Ação |
|---|---|
| `prefix + F` | Ativar hints do fastcopy |

Reconhece: URLs, IPs, hashes Git, caminhos de arquivos, UUIDs, cores hex, números e mais.

> Usa `prefix + F` (maiúsculo) — `prefix + f` é preservado para o `find-window` nativo do tmux.

---

### Abertura de URLs e Arquivos

#### [tmux-plugins/tmux-open](https://github.com/tmux-plugins/tmux-open)

Abre texto destacado no modo de cópia.

| Keybind | Contexto | Ação |
|---|---|---|
| `o` | Modo de cópia | Abrir com app padrão do sistema |
| `Ctrl + o` | Modo de cópia | Abrir com `$EDITOR` |
| `Shift + s` | Modo de cópia | Buscar seleção no browser |

#### [wfxr/tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url)

Lista todas as URLs visíveis com fzf para abertura rápida.

| Keybind | Ação |
|---|---|
| `prefix + u` | Abrir seletor de URLs |

> `u` não é um binding padrão do tmux — sem conflito.

---

### Gerenciamento de Sessões

#### [tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)

Salva e restaura o ambiente completo do tmux após reboots.

| Keybind | Ação |
|---|---|
| `prefix + Ctrl+s` | Salvar sessão |
| `prefix + Ctrl+r` | Restaurar sessão |

Salva: windows, panes, diretórios de trabalho, conteúdo dos panes, programas em execução.

#### [tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)

Salvamento e restauração automáticos de sessão.

| Funcionalidade | Valor |
|---|---|
| Intervalo de auto-save | A cada 10 minutos |
| Auto-restore na inicialização | Ativado |

Sem keybinds — funciona automaticamente em segundo plano.

#### [omerxx/tmux-sessionx](https://github.com/omerxx/tmux-sessionx)

Gerenciador de sessões completo com preview via fzf.

| Keybind | Ação |
|---|---|
| `prefix + S` | Abrir gerenciador de sessões |

Dentro do sessionx: `Ctrl+d` deletar sessão, `Ctrl+r` renomear, `Tab` alternar preview.

> Usa `prefix + S` (maiúsculo) — `prefix + o` é preservado para o `rotate-pane` nativo do tmux.

---

### Fuzzy Finder

#### [sainnhe/tmux-fzf](https://github.com/sainnhe/tmux-fzf)

Gerencia sessões, windows, panes e executa comandos via fzf.

| Keybind | Ação |
|---|---|
| `prefix + F` (maiúsculo) | Abrir menu tmux-fzf |

---

### Auxiliares de UI

#### [Freed-Wu/tmux-digit](https://github.com/Freed-Wu/tmux-digit)

Overlay visual de números para troca rápida de windows.

| Keybind | Ação |
|---|---|
| `prefix + 0–9` | Ir diretamente para window pelo índice |

#### [anghootys/tmux-ip-address](https://github.com/anghootys/tmux-ip-address)

Exibe o endereço IP atual da máquina na barra de status. Sem keybinds.

#### [tmux-plugins/tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight)

Destaca a barra de status quando o prefix está ativo, no modo de cópia ou no modo de sync. Sem keybinds.

#### [alexwforsythe/tmux-which-key](https://github.com/alexwforsythe/tmux-which-key)

Exibe um popup interativo com todos os keybinds disponíveis — sem necessidade de memorizar.

| Keybind | Ação |
|---|---|
| `prefix + Space` | Abrir menu which-key |

> `prefix + Space` é intencionalmente atribuído ao which-key. O next-layout ainda está disponível via `prefix + Alt+1–5`.

#### [jaclu/tmux-menus](https://github.com/jaclu/tmux-menus)

Menus popup contextuais para sessões, windows, panes e configurações.

| Keybind | Ação |
|---|---|
| `prefix + g` | Abrir menu de contexto |

> Usa `prefix + g` — evita conflito com `prefix + M` (clear mark) e `prefix + \` (split do pain-control).

---

### Tema

#### [2KAbhishek/tmux2k](https://github.com/2KAbhishek/tmux2k)

Barra de status rica em recursos com widgets e múltiplos temas.

**Layout configurado:**

| Posição | Widgets |
|---|---|
| Esquerda | `git` · `cwd` · `docker` · `mise` |
| Direita | `cpu` · `ram` · `network` · `time` |

**Tema:** `onedark` com separadores powerline (``, ``).

---

## Resolução de Conflitos de Teclas

O tmux possui muitos keybinds nativos. A tabela abaixo mostra todos os conflitos encontrados e como foram resolvidos no [`tmux.conf`](../../conf/tmux.conf).

| Tecla | Padrão tmux | Plugin | Resolução |
|---|---|---|---|
| `prefix + f` | `find-window` | tmux-fastcopy | Fastcopy movido para `prefix + F` — padrão preservado |
| `prefix + o` | `rotate-pane` | tmux-sessionx | Sessionx movido para `prefix + S` — padrão preservado |
| `prefix + l` | `last-window` | tmux-pain-control | Padrão restaurado com `bind-key l last-window` após carregar o TPM |
| `prefix + -` | `delete-buffer` | tmux-pain-control | Pain-control sobrescreve com split-h — aceito (padrão raramente usado) |
| `prefix + \` | *(split do pain-control)* | tmux-menus | Menus movidos para `prefix + g` — split do pain-control preservado |
| `prefix + M` | `select-pane -M` (clear mark) | tmux-menus | Menus movidos para `prefix + g` — padrão preservado |
| `prefix + Space` | `next-layout` | tmux-which-key | which-key usa o Space — next-layout disponível via `prefix + Alt+1–5` |
