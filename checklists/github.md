# Checklist: GitHub Repository e Actions Security

## Repositorio

- [ ] Branch protection habilitada para branches principais.
- [ ] Required reviews habilitados.
- [ ] Force push bloqueado em branches protegidas.
- [ ] CODEOWNERS cobre `.github/`, workflows, `package.json`, lockfiles, publish configs e IaC.
- [ ] Dependabot/secret scanning/code scanning habilitados quando disponiveis.

## GitHub Actions

- [ ] `GITHUB_TOKEN` usa permissao minima por workflow/job.
- [ ] `permissions: write-all` foi removido ou justificado.
- [ ] Actions de terceiros estao pinadas por SHA quando possivel.
- [ ] `pull_request_target` nao faz checkout nem executa codigo do PR.
- [ ] `workflow_run` nao executa artifacts nao confiaveis em contexto privilegiado.

## Cache e artifacts

- [ ] Cache keys separam forks, branches nao confiaveis e branches protegidas.
- [ ] Jobs de PR nao gravam cache lido por jobs privilegiados.
- [ ] Artifacts de PR sao tratados como dados nao confiaveis.
- [ ] Artifacts usados em release sao assinados ou reconstruidos em contexto confiavel.
- [ ] Caches foram invalidados apos qualquer suspeita de poisoning.

## OIDC e trusted publishing

- [ ] OIDC usa claims restritos para repositorio, branch, workflow e environment.
- [ ] npm trusted publishing esta restrito ao workflow correto.
- [ ] Job de publish nao consome build output de PR nao confiavel.
- [ ] Tokens long-lived de npm/cloud foram removidos quando OIDC e suficiente.
- [ ] Environment protection exige reviewers para publish/deploy sensivel.

## Resposta a suspeita

- [ ] Workflow malicioso ou commit suspeito foi preservado antes de remover.
- [ ] Workflow runs, logs, artifacts e caches foram preservados.
- [ ] Tokens, deploy keys e secrets foram rotacionados.
- [ ] Publicacoes em npm/GitHub Packages foram auditadas.
- [ ] Contas de maintainer e bot foram revisadas contra infostealer compromise.
