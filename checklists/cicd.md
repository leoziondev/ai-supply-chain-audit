# Checklist: CI/CD Supply Chain

## Eventos e trust boundaries

- [ ] Workflows acionados por PR externo foram identificados.
- [ ] Uso de `pull_request_target` foi revisado.
- [ ] Jobs que executam codigo nao confiavel nao recebem secrets.
- [ ] Jobs de release/deploy sao separados dos jobs de teste de PR.
- [ ] Environments protegidos exigem aprovacao quando necessario.

## Permissoes

- [ ] `GITHUB_TOKEN` usa permissao minima.
- [ ] `permissions: write-all` foi removido ou justificado.
- [ ] Tokens de publish, cloud e deploy sao escopados por ambiente.
- [ ] OIDC usa audience, subject e roles restritos.
- [ ] Secrets nao aparecem em logs, artifacts ou caches.

## Dependencias de pipeline

- [ ] Actions estao pinadas por SHA quando possivel.
- [ ] Imagens Docker usam digest ou versao imutavel.
- [ ] Scripts externos baixados em runtime foram eliminados ou validados.
- [ ] Caches nao cruzam fronteiras entre branches confiaveis e nao confiaveis.
- [ ] Artifacts de PR nao sao usados diretamente em release.

## Build e release

- [ ] Build usa lockfile (`npm ci`, `composer install`) em vez de resolver versoes novas sem controle.
- [ ] Scripts de lifecycle sao desabilitados durante triagem quando necessario.
- [ ] SBOM e gerado em release.
- [ ] Artifacts sao assinados ou associados a provenance.
- [ ] Releases podem ser reproduzidas a partir de commit e lockfile.

## Resposta a suspeita

- [ ] Workflows afetados pausados.
- [ ] Runners efemeros descartados ou hosts persistentes isolados.
- [ ] Tokens de pipeline rotacionados.
- [ ] Logs e artifacts preservados.
- [ ] Repositorios e registries auditados para publicacoes indevidas.
