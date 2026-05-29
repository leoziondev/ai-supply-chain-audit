# Exemplo: Auditoria CI/CD

Este exemplo mostra como preparar uma entrada para o prompt principal ao revisar pipelines com risco de workflow poisoning, secrets leakage e artifact poisoning.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- Actions ou imagens nao fixadas por SHA/digest.
- Permissoes excessivas de `GITHUB_TOKEN`.
- Uso perigoso de `pull_request_target`.
- Execucao de codigo nao confiavel com acesso a secrets.
- Artifacts e caches usados como ponte entre jobs confiaveis e nao confiaveis.

## Arquivos que o usuario deve fornecer

```text
.github/workflows/*
.gitlab-ci.yml
Jenkinsfile
azure-pipelines.yml
scripts/*
Dockerfile
package.json
composer.json
logs de jobs relevantes
configuracao de environments e secrets, se puder ser compartilhada com seguranca
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os arquivos abaixo.

### .github/workflows/pr-check.yml

```yaml
name: pr-check

on:
  pull_request_target:
    types: [opened, synchronize, reopened]

permissions: write-all

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: ${{ github.event.pull_request.head.sha }}
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm install
        env:
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      - run: npm test
      - uses: actions/upload-artifact@v4
        with:
          name: build-output
          path: dist/
```

### .github/workflows/release.yml

```yaml
name: release

on:
  workflow_run:
    workflows: ["pr-check"]
    types: [completed]

permissions:
  contents: write
  packages: write

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with:
          name: build-output
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

### .gitlab-ci.yml

```yaml
stages:
  - build
  - deploy

build:
  image: node:latest
  stage: build
  script:
    - npm install
    - npm run build
  artifacts:
    paths:
      - dist/

deploy:
  image: alpine:latest
  stage: deploy
  script:
    - sh scripts/deploy.sh
  dependencies:
    - build
  only:
    - main
```

## Riscos que o prompt deve encontrar

- `pull_request_target` com checkout do SHA do PR permite executar codigo de fork no contexto privilegiado.
- `permissions: write-all` e secrets no job ampliam impacto de malware em dependencias.
- `npm install` executa scripts de lifecycle por padrao.
- Artifact `dist/` gerado em contexto nao confiavel pode ser consumido por workflow de release.
- Actions usam tags mutaveis em vez de SHA pinado.
- GitLab usa `node:latest` e `alpine:latest`, ambos mutaveis.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CICD-001 | Critico | Workflow poisoning | `pull_request_target` faz checkout de codigo do PR e roda `npm install` com secrets | PR externo pode executar codigo com credenciais | `pull_request_target`, `permissions: write-all`, `NPM_TOKEN` | T1195.002, T1059 | Atacante abre PR com package/script malicioso | Usar `pull_request`, remover secrets de PR, reduzir permissoes, usar `npm ci --ignore-scripts` para triagem |

## Validacoes manuais recomendadas

```bash
grep -R "pull_request_target\|permissions: write-all\|npm install\|download-artifact\|upload-artifact" .github/workflows .gitlab-ci.yml 2>/dev/null
grep -R "latest" .github/workflows .gitlab-ci.yml Dockerfile 2>/dev/null
```

Se um workflow privilegiado executou codigo de PR externo com secrets, trate o runner e os tokens como potencialmente comprometidos.
