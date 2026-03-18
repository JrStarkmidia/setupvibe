# SetupVibe

> O script definitivo de configuração de ambiente de desenvolvimento multiplataforma — v0.32.0

## Visão Geral

**SetupVibe** é um script de configuração automatizado e abrangente que transforma seu ambiente de desenvolvimento em um workspace moderno e poderoso. Instala e configura uma stack completa de desenvolvimento em um único comando, com suporte a macOS e às principais distribuições Linux.

Ideal para desenvolvedores, engenheiros de DevOps e administradores de sistemas que desejam um ambiente totalmente configurado sem a necessidade de configuração manual.

## Requisitos do Sistema

| | Suportado |
|---|---|
| **macOS** | 12 Monterey ou superior |
| **Ubuntu** | 24.04+ |
| **Debian** | 12+ |
| **Zorin OS** | 18+ |
| **Linux Mint** | 21+ |
| **Arquiteturas** | x86_64 (amd64), ARM64 (aarch64) |

## Instalação

### Desktop (macOS e Linux)

```bash
curl -sL https://raw.githubusercontent.com/promovaweb/setupvibe/refs/heads/main/desktop.sh | bash
```

### Servidor (somente Linux)

```bash
curl -sL https://raw.githubusercontent.com/promovaweb/setupvibe/refs/heads/main/server.sh | bash
```

> O processo leva de 20 a 60 minutos dependendo da velocidade da sua internet e do hardware.

---

## Desktop — O que é instalado

**14 etapas, totalmente automatizadas.**

| Etapa | O que faz |
|---|---|
| 1. Sistema Base e Build Tools | Compiladores essenciais, curl, git, build-essential |
| 2. Homebrew | Gerenciador de pacotes para macOS e Linux |
| 3. Ecossistema PHP 8.4 | PHP, Composer, Laravel installer |
| 4. Ecossistema Ruby | rbenv, Ruby, Bundler, Rails |
| 5. Linguagens | Go, Rust, Python + gerenciador `uv` |
| 6. JavaScript | Node.js, Bun, PNPM, PM2 |
| 7. DevOps | Docker, Docker Compose, Ansible, GitHub CLI |
| 8. Ferramentas Unix Modernas | bat, eza, fd, ripgrep, fzf, zoxide, delta e mais |
| 9. Rede e Monitoramento | nmap, htop, Tailscale e outros |
| 10. Servidor SSH | OpenSSH server (somente Linux) |
| 11. Shell | ZSH, Oh My Zsh, Starship prompt (Gruvbox Rainbow) |
| 12. Tmux e Plugins | TPM + tmux.conf com conjunto completo de plugins |
| 13. Ferramentas de IA CLI | claude-code, gemini-cli, codex, copilot-cli |
| 14. Finalização e Limpeza | Temp files, logs, purge de cache; auto-startup e defaults do PM2 |

---

## Servidor — O que é instalado

**11 etapas, somente Linux, sem ferramentas de desktop ou linguagens de desenvolvimento.**

| Etapa | O que faz |
|---|---|
| 0. Pré-requisitos | Verificação de arquitetura, preparação do APT |
| 1. Sistema Base e Build Tools | Pacotes essenciais e ferramentas de build |
| 2. Homebrew | Gerenciador de pacotes |
| 3. Docker, Ansible e GitHub CLI | Runtime de containers e ferramentas DevOps |
| 4. Ferramentas Unix Modernas | Utilitários de produtividade CLI via Brew |
| 5. Rede e Monitoramento | nmap, htop, Tailscale |
| 6. Servidor SSH | Configuração do OpenSSH server |
| 7. Shell | ZSH, Oh My Zsh, Starship prompt (Gruvbox Rainbow) |
| 8. Tmux e Plugins | TPM + tmux.conf com conjunto completo de plugins |
| 9. Ferramentas de IA CLI | claude-code, gemini-cli, codex, copilot-cli |
| 10. Finalização | Limpeza e validação |

---

## Configuração do Shell

Cada ambiente recebe um `.zshrc` dedicado baixado deste repositório:

| Arquivo | Usado por |
|---|---|
| [`zshrc-macos.zsh`](../../conf/zshrc-macos.zsh) | desktop.sh no macOS |
| [`zshrc-linux.zsh`](../../conf/zshrc-linux.zsh) | desktop.sh no Linux |
| [`zshrc-server.zsh`](../../conf/zshrc-server.zsh) | server.sh |

Todas as configs incluem:
- Configuração do PATH do Homebrew
- Oh My Zsh com conjunto curado de plugins
- Starship prompt (preset Gruvbox Rainbow)
- Exportações de PATH para zoxide, fzf, Rust, Go, Bun, rbenv
- Aliases úteis (`d`, `dc`, `art`, `brewup`, `reload`, etc.)

---

## Configuração do Tmux

Um [`tmux.conf`](../../conf/tmux.conf) compartilhado é baixado e aplicado em ambos os setups. Para documentação completa, referência de keybindings e guia de plugins, veja **[tmux.md](tmux.md)**.

### Plugins

| Categoria | Plugin |
|---|---|
| Core | tmux-plugins/tpm, tmux-plugins/tmux-sensible |
| Navegação | tmux-plugins/tmux-pain-control, christoomey/vim-tmux-navigator |
| Mouse | NHDaly/tmux-better-mouse-mode |
| Cópia e Clipboard | tmux-plugins/tmux-yank, CrispyConductor/tmux-copy-toolkit, abhinav/tmux-fastcopy |
| URL e Arquivos | tmux-plugins/tmux-open, wfxr/tmux-fzf-url |
| Sessões | tmux-plugins/tmux-resurrect, tmux-plugins/tmux-continuum, omerxx/tmux-sessionx |
| Fuzzy Finder | sainnhe/tmux-fzf |
| UI | Freed-Wu/tmux-digit, anghootys/tmux-ip-address, tmux-plugins/tmux-prefix-highlight, alexwforsythe/tmux-which-key, jaclu/tmux-menus |
| Tema | 2KAbhishek/tmux2k (onedark, com git/cwd/docker/mise/cpu/ram/network/time) |

Após a instalação, pressione `prefix + I` dentro do tmux para instalar todos os plugins.

---

## Gerenciador de Processos PM2

O PM2 é instalado globalmente e configurado para iniciar automaticamente no boot — via launchd no macOS e systemd no Linux. Um template padrão `~/ecosystem.config.js` é gerado durante o setup com defaults para timestamps de log, limites de memória, recuperação de crashes e alternância de ambientes.

Para documentação completa, referência de configuração e guia de comandos, veja **[pm2.md](pm2.md)**.

---

## Ferramentas de IA CLI

Instaladas globalmente via npm em ambos os setups:

| Ferramenta | Pacote |
|---|---|
| Claude Code | `@anthropic-ai/claude-code` |
| Gemini CLI | `@google/gemini-cli` |
| OpenAI Codex | `@openai/codex` |
| GitHub Copilot CLI | `@githubnext/github-copilot-cli` |

---

## Licença

Licenciado sob a **GNU General Public License v3.0** — veja [LICENSE](../../LICENSE) para detalhes.

## Créditos

Mantido por [promovaweb.com](https://promovaweb.com) · contact@promovaweb.com

---

**SetupVibe** — Seu ambiente de desenvolvimento definitivo, automatizado.
