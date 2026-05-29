# Exemplo: Auditoria Node.js / npm

Este exemplo mostra como preparar uma entrada para o prompt principal ao investigar um projeto Node.js com suspeita de risco em dependencias npm.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- Scripts npm que executam codigo durante instalacao.
- Dependencias suspeitas adicionadas sem uso claro.
- Lockfile criado durante janela de exposicao.
- Risco de exfiltracao de secrets em CI/CD.
- Necessidade de rotacao quando o build runner pode ter executado malware.

## Arquivos que o usuario deve fornecer

```text
package.json
package-lock.json
pnpm-lock.yaml ou yarn.lock, se existirem
.npmrc
.github/workflows/*
Dockerfile
src/*
logs de build relevantes
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os arquivos abaixo.

### package.json

```json
{
  "name": "customer-portal-api",
  "version": "1.8.2",
  "private": true,
  "scripts": {
    "preinstall": "node scripts/setup-env.js",
    "build": "tsc -p tsconfig.json",
    "test": "vitest run",
    "start": "node dist/server.js"
  },
  "dependencies": {
    "axios": "^1.14.1",
    "express": "^4.19.2",
    "jsonwebtoken": "^9.0.2",
    "opensearch-setup": "1.0.9103",
    "plain-crypto-js": "4.2.1"
  },
  "devDependencies": {
    "typescript": "^5.5.4",
    "vitest": "^2.0.5"
  }
}
```

### scripts/setup-env.js

```js
const { execSync } = require("child_process");

if (process.env.CI) {
  execSync("node node_modules/opensearch-setup/setup.mjs", {
    stdio: "inherit",
  });
}
```

### .github/workflows/build.yml

```yaml
name: build

on:
  pull_request:
  push:
    branches: [main]

permissions: write-all

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm install
        env:
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      - run: npm test
      - run: npm publish
        if: github.ref == 'refs/heads/main'
```

## Riscos que o prompt deve encontrar

- `npm install` executa scripts de lifecycle por padrao.
- `preinstall` chama codigo local que executa arquivo dentro de `node_modules`.
- `opensearch-setup` parece typosquat de ecossistema OpenSearch.
- `plain-crypto-js` parece dependencia suspeita e similar a `crypto-js`.
- `axios` com range permissivo e versao de exemplo associada a incidente deve ser tratado como alerta que precisa de confirmacao em lockfile.
- Workflow usa `permissions: write-all`.
- Secrets cloud e npm estao disponiveis no mesmo passo que instala dependencias.
- `npm publish` pode ampliar o impacto se o token for exfiltrado.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NPM-001 | Critico | Malware / lifecycle hook | `package.json` usa `preinstall`; workflow executa `npm install` com secrets | Possivel execucao durante install e roubo de tokens | `opensearch-setup`, `plain-crypto-js`, `preinstall` | T1195.002, T1059 | Executa em CI com secrets disponiveis | Isolar runner, rotacionar tokens, remover pacotes, usar `npm ci --ignore-scripts` ate validar |

## Validacoes manuais recomendadas

```bash
npm ls opensearch-setup plain-crypto-js axios
npm view opensearch-setup --json
npm audit --omit=dev
grep -R "preinstall\|postinstall\|child_process\|curl\|wget" package.json scripts node_modules 2>/dev/null
```

Se algum pacote suspeito tiver executado em runner com secrets, trate como incidente ate prova em contrario.
