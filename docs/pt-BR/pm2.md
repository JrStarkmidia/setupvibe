# Guia do PM2

O SetupVibe instala o [PM2](https://pm2.keymetrics.io/) globalmente e o configura para iniciar automaticamente no boot. Um template padrão [`ecosystem.config.js`](https://pm2.keymetrics.io/docs/usage/application-declaration/) é gerado no seu diretório home durante o setup.

---

## O que é o PM2?

O PM2 é um **gerenciador de processos de produção para Node.js** — mantém suas aplicações no ar, reinicia em caso de crash, gerencia logs e integra com os sistemas de init do sistema operacional (launchd no macOS, systemd no Linux).

**Conceitos principais:**

| Conceito | Descrição |
|---|---|
| **App** | Um processo gerenciado pelo PM2 (Node.js, Python, Go ou qualquer binário) |
| **Ecosystem file** | `ecosystem.config.js` — configuração declarativa para uma ou mais apps |
| **Cluster mode** | Cria múltiplas instâncias distribuídas pelos núcleos da CPU (somente Node.js) |
| **Fork mode** | Processo único, funciona com qualquer runtime (padrão) |

---

## Primeiros Passos

```bash
# Iniciar uma app diretamente
pm2 start app.js

# Iniciar com um nome
pm2 start app.js --name minhaapp

# Iniciar usando ecosystem file
pm2 start ecosystem.config.js

# Iniciar uma app específica do ecosystem file
pm2 start ecosystem.config.js --only minhaapp

# Iniciar com um ambiente específico
pm2 start ecosystem.config.js --env production

# Listar todos os processos gerenciados
pm2 list

# Mostrar informações detalhadas de uma app
pm2 show minhaapp

# Monitorar todas as apps em tempo real
pm2 monit
```

---

## Comandos Comuns

### Controle de Processos

```bash
pm2 stop minhaapp          # Parar (mantém na lista)
pm2 restart minhaapp       # Reiniciar
pm2 reload minhaapp        # Reload sem downtime (modo cluster)
pm2 delete minhaapp        # Parar e remover da lista

pm2 stop all               # Parar todas as apps
pm2 restart all            # Reiniciar todas as apps
pm2 delete all             # Remover todas as apps
```

### Logs

```bash
pm2 logs                   # Transmitir todos os logs
pm2 logs minhaapp          # Transmitir logs de uma app
pm2 logs --lines 200       # Mostrar últimas 200 linhas
pm2 flush                  # Limpar todos os arquivos de log
pm2 reloadLogs             # Reabrir arquivos de log (útil após rotação)
```

### Persistência

```bash
pm2 save                   # Salvar lista de processos no disco
pm2 resurrect              # Restaurar lista de processos salva
```

### Startup

```bash
# Gerar e configurar integração com o sistema de init
pm2 startup                # Exibe o comando — execute com sudo

# Remover hook de startup
pm2 unstartup
```

---

## Ecosystem File

O ecosystem file (`ecosystem.config.js`) é a forma recomendada de gerenciar apps. Um template é gerado em `~/ecosystem.config.js` durante o setup do SetupVibe.

### Template Padrão

```js
module.exports = {
  apps: [
    {
      name: "app",
      script: "./index.js",
      instances: 1,
      exec_mode: "fork",
      watch: false,
      ignore_watch: ["node_modules", "logs", ".git"],
      max_memory_restart: "300M",
      log_date_format: "YYYY-MM-DD HH:mm:ss",
      merge_logs: true,
      time: true,
      autorestart: true,
      max_restarts: 10,
      restart_delay: 1000,
      kill_timeout: 3000,
      wait_ready: false,
      env: {
        NODE_ENV: "development",
      },
      env_production: {
        NODE_ENV: "production",
      },
    },
  ],
};
```

---

## Referência de Configuração

Referência completa de opções conforme a [documentação PM2 Application Declaration](https://pm2.keymetrics.io/docs/usage/application-declaration/).

### Geral

| Opção | Tipo | Padrão | Descrição |
|---|---|---|---|
| `name` | string | nome do script | Identificador da app usado em `pm2 list` e comandos |
| `script` | string | — | Caminho para o script de entrada (obrigatório) |
| `cwd` | string | — | Diretório de trabalho do processo |
| `args` | string | — | Argumentos CLI passados ao script |
| `interpreter` | string | `node` | Caminho para o interpretador de runtime |
| `interpreter_args` | string | — | Flags passadas ao interpretador (ex: `--max-old-space-size=4096`) |
| `force` | boolean | `false` | Permitir iniciar o mesmo script mais de uma vez |

### Escalabilidade

| Opção | Tipo | Padrão | Descrição |
|---|---|---|---|
| `instances` | number | `1` | Número de instâncias; `-1` = todos os núcleos da CPU |
| `exec_mode` | string | `fork` | `fork` (qualquer runtime) ou `cluster` (somente Node.js) |

### Estabilidade e Restart

| Opção | Tipo | Padrão | Descrição |
|---|---|---|---|
| `autorestart` | boolean | `true` | Reiniciar em caso de crash |
| `max_restarts` | number | `10` | Máximo de restarts instáveis consecutivos antes de parar |
| `min_uptime` | string/number | — | Uptime mínimo (ms ou string como `"2s"`) para ser considerado estável |
| `restart_delay` | number | `0` | Milissegundos de espera antes de reiniciar uma app com crash |
| `max_memory_restart` | string | — | Reiniciar se o RSS ultrapassar este valor (ex: `"300M"`, `"1G"`) |
| `kill_timeout` | number | `1600` | Milissegundos antes do SIGKILL após SIGTERM |
| `shutdown_with_message` | boolean | `false` | Usar `process.send('shutdown')` em vez de SIGTERM |
| `wait_ready` | boolean | `false` | Aguardar `process.send('ready')` antes de considerar a app online |
| `listen_timeout` | number | — | Milissegundos para aguardar sinal `ready` antes de forçar reload |

### Watch

| Opção | Tipo | Padrão | Descrição |
|---|---|---|---|
| `watch` | boolean/array | `false` | Reiniciar ao detectar alterações em arquivos; passe um array de caminhos para monitorar |
| `ignore_watch` | array | — | Caminhos ou padrões glob excluídos do watch |

### Logs

| Opção | Tipo | Padrão | Descrição |
|---|---|---|---|
| `log_date_format` | string | — | Formato de timestamp (ex: `"YYYY-MM-DD HH:mm:ss"`) |
| `out_file` | string | `~/.pm2/logs/<name>-out.log` | Caminho para log de stdout |
| `error_file` | string | `~/.pm2/logs/<name>-error.log` | Caminho para log de stderr |
| `log_file` | string | — | Caminho para log combinado stdout+stderr |
| `merge_logs` / `combine_logs` | boolean | `false` | Desabilitar sufixos de instância nos logs em modo cluster |
| `time` | boolean | `false` | Prefixar automaticamente cada linha de log com timestamp |

### Ambiente

| Opção | Tipo | Descrição |
|---|---|---|
| `env` | object | Variáveis injetadas em todos os modos |
| `env_<nome>` | object | Variáveis injetadas ao iniciar com `--env <nome>` (ex: `env_production`) |
| `filter_env` | array | Remove variáveis globais de ambiente que começam com esses prefixos |
| `instance_var` | string | Nome da variável que armazena o índice da instância (padrão: `NODE_APP_INSTANCE`) |
| `appendEnvToName` | boolean | Acrescentar o nome do ambiente ao nome da app |

### Source Maps e Outros

| Opção | Tipo | Padrão | Descrição |
|---|---|---|---|
| `source_map_support` | boolean | `true` | Ativar suporte a source maps para stack traces |
| `vizion` | boolean | `true` | Rastrear metadados de controle de versão |
| `cron_restart` | string | — | Expressão cron para restarts programados (ex: `"0 3 * * *"`) |
| `post_update` | array | — | Comandos a executar após uma atualização via `pm2 pull` |

---

## Configurações Globais do PM2

O SetupVibe configura estes defaults no nível do módulo durante o setup:

| Configuração | Valor | Descrição |
|---|---|---|
| `pm2:autodump` | `true` | Auto-salvar a lista de processos em qualquer alteração |
| `pm2:log_date_format` | `YYYY-MM-DD HH:mm:ss` | Formato padrão de timestamp para todos os logs |

Gerencie manualmente com:

```bash
pm2 set pm2:autodump true
pm2 set pm2:log_date_format "YYYY-MM-DD HH:mm:ss"
pm2 get                      # Listar todas as configurações atuais do módulo PM2
```

---

## Modo Cluster (Node.js)

```js
{
  instances: "max",   // ou um número, ou -1
  exec_mode: "cluster",
}
```

```bash
pm2 reload minhaapp      # Reload sem downtime em modo cluster
pm2 scale minhaapp 4     # Escalar para 4 instâncias em tempo de execução
pm2 scale minhaapp +2    # Adicionar 2 instâncias
```

---

## Auto-Startup

O SetupVibe configura o PM2 para iniciar automaticamente no boot:

- **macOS** — registra um agente launchd
- **Linux** — registra um serviço systemd

Para reconfigurar manualmente:

```bash
pm2 startup            # Exibe o comando a executar
pm2 save               # Salva a lista de processos atual
```

Para remover:

```bash
pm2 unstartup
```
