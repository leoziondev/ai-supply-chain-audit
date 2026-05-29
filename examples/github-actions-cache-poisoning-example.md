# Exemplo: GitHub Actions Cache Poisoning e Trusted Publishing

Este exemplo mostra como preparar uma entrada para o prompt principal ao revisar um pipeline com `pull_request_target`, cache compartilhado e publish npm via OIDC.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- `pull_request_target` executando codigo de PR nao confiavel.
- Cache escrito por fork e lido por job privilegiado.
- OIDC trusted publishing usado em workflow que pode receber artefato/cache contaminado.
- Falta de CODEOWNERS e branch protection para arquivos sensiveis.
- Necessidade de separar build nao confiavel de publish confiavel.

## Arquivos que o usuario deve fornecer

```text
.github/workflows/*
CODEOWNERS
package.json
package-lock.json ou pnpm-lock.yaml
npm package trusted publisher settings
branch protection settings
workflow run logs
cache/artifact metadata
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os arquivos abaixo.

### .github/workflows/pr.yml

```yaml
name: pr

on:
  pull_request_target:

permissions:
  contents: write
  id-token: write

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.pull_request.head.sha }}
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          cache: pnpm
      - run: corepack enable
      - run: pnpm install
      - run: pnpm test
```

### .github/workflows/publish.yml

```yaml
name: publish

on:
  push:
    branches: [main]

permissions:
  contents: read
  id-token: write

jobs:
  publish:
    runs-on: ubuntu-latest
    environment: npm
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
          registry-url: https://registry.npmjs.org
          cache: pnpm
      - run: corepack enable
      - run: pnpm install
      - run: pnpm build
      - run: npm publish
```

### CODEOWNERS

```text
# Missing owners for .github workflows and package manager files.
/src/ @frontend-team
```

## Riscos que o prompt deve encontrar

- `pull_request_target` com checkout do SHA do PR cria pwn request.
- `id-token: write` no workflow de PR amplia risco de extracao de OIDC token.
- Cache pnpm pode atravessar fronteira fork/base se keys nao isolarem trust zone.
- Trusted publishing reduz token long-lived, mas nao protege contra publish autenticado por pipeline contaminado.
- `CODEOWNERS` nao protege `.github/`, lockfiles nem publish workflow.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GH-001 | Critico | Pwn request / cache poisoning | `pull_request_target` faz checkout de PR head e usa cache pnpm | PR externo pode contaminar cache ou executar codigo com privilegios | `pull_request_target`, `id-token: write`, cache pnpm | T1195.002, T1059 | Atacante abre PR com scripts/dependencias maliciosas | Migrar para `pull_request`, remover OIDC do PR, isolar cache e proteger publish workflow |

## Validacoes manuais recomendadas

```bash
grep -R "pull_request_target\|id-token: write\|cache:\|workflow_run\|npm publish" .github/workflows CODEOWNERS 2>/dev/null
```

Trate artifacts e caches vindos de PR como dados nao confiaveis, nunca como binarios ou dependencias executaveis em job privilegiado.
