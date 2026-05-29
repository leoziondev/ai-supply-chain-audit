# Exemplo: Auditoria TanStack Supply Chain

Este exemplo mostra como preparar uma entrada para o prompt principal ao investigar uso de TanStack Start/Router apos advisories de malware em pacotes `@tanstack/*`.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- Dependencias `@tanstack/*` em lockfile.
- Indicadores publicos como `@tanstack/setup`, `router_init.js` e git dependency suspeita.
- Execucao de install scripts em CI ou maquina de developer.
- Exposicao de AWS, GCP, Vault, Kubernetes, GitHub, npm e SSH keys.
- Necessidade de tratar installs na janela afetada como incidente.

## Arquivos que o usuario deve fornecer

```text
package.json
package-lock.json ou pnpm-lock.yaml
yarn.lock, se existir
.npmrc
.github/workflows/*
logs de npm/pnpm/yarn install
logs de proxy/DNS/EDR
inventario de secrets acessiveis ao runner
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os arquivos abaixo.

### package.json

```json
{
  "name": "ops-console",
  "private": true,
  "scripts": {
    "build": "vite build",
    "test": "vitest run"
  },
  "dependencies": {
    "@tanstack/react-router": "1.120.3",
    "@tanstack/router-plugin": "1.120.3",
    "@tanstack/react-query": "^5.80.0",
    "@vitejs/plugin-react": "^5.0.0"
  },
  "devDependencies": {
    "vite": "^6.0.0",
    "typescript": "^5.8.0"
  }
}
```

### package-lock excerpt

```json
{
  "node_modules/@tanstack/react-router": {
    "version": "1.120.3",
    "resolved": "https://registry.npmjs.org/@tanstack/react-router/-/react-router-1.120.3.tgz",
    "integrity": "sha512-demo"
  },
  "node_modules/@tanstack/router-plugin": {
    "version": "1.120.3",
    "optionalDependencies": {
      "@tanstack/setup": "github:tanstack/router#79ac49eedf774dd4b0cfa308722bc463cfe5885c"
    }
  }
}
```

### .github/workflows/test.yml

```yaml
name: test

on:
  pull_request:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: npm
      - run: npm install
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
      - run: npm test
```

## Riscos que o prompt deve encontrar

- Presenca de `@tanstack/setup` como `optionalDependencies` deve ser tratada como IOC critico.
- Git dependency para `github:tanstack/router#79ac49...` deve ser investigada sem executar scripts.
- `npm install` com AWS e npm tokens disponiveis amplia impacto.
- Se install ocorreu na janela afetada, runner e credenciais devem ser considerados comprometidos ate prova em contrario.
- Cache npm precisa ser invalidado apos suspeita.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TAN-001 | Critico | Malware em dependencia | Lockfile inclui `@tanstack/setup` via git ref conhecido | Install pode executar payload e exfiltrar secrets | `@tanstack/setup`, `router_init.js`, git ref `79ac49...` | T1195.002, T1552 | Executa durante install com tokens no ambiente | Preservar logs, rotacionar secrets, invalidar cache, pin para versao segura e reconstruir runners |

## Validacoes manuais recomendadas

```bash
npm ls @tanstack/react-router @tanstack/router-plugin @tanstack/setup
grep -R "@tanstack/setup\|router_init.js\|tanstack_runner.js\|79ac49eedf774dd4b0cfa308722bc463cfe5885c" package*.json pnpm-lock.yaml yarn.lock . 2>/dev/null
npm pack @tanstack/react-router@1.120.3 --ignore-scripts
```

Nao execute `npm install` em ambiente com secrets antes de concluir a triagem.
