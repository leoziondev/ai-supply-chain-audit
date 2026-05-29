# Checklist: Containers e Runtime

## Dockerfile e imagem

- [ ] Imagem base usa versao especifica ou digest.
- [ ] Container nao roda como root sem justificativa.
- [ ] `curl | sh`, downloaders e scripts remotos foram revisados.
- [ ] Secrets nao aparecem em `ARG`, `ENV` ou layers.
- [ ] Multi-stage build nao copia arquivos sensiveis para a imagem final.

## Dependencias na imagem

- [ ] Lockfiles sao copiados antes de instalar dependencias.
- [ ] `npm ci` ou `composer install` usa lockfile.
- [ ] Scripts de instalacao sao controlados durante triagem.
- [ ] SBOM da imagem foi gerado.
- [ ] Imagem foi escaneada por vulnerabilidades e malware conhecido.

## Runtime

- [ ] Container nao usa `privileged: true`.
- [ ] Docker socket nao e montado no container.
- [ ] Filesystem read-only quando possivel.
- [ ] Capabilities Linux sao minimas.
- [ ] Egress de rede e restrito para workloads sensiveis.
- [ ] Metadata endpoints cloud sao protegidos.

## Kubernetes

- [ ] ServiceAccount tem RBAC minimo.
- [ ] Secrets nao sao montados em pods sem necessidade.
- [ ] Admission policies bloqueiam imagens sem digest ou sem assinatura, quando aplicavel.
- [ ] NetworkPolicies limitam comunicacao lateral.
- [ ] Pods usam securityContext restritivo.

## Resposta a suspeita

- [ ] Imagens afetadas removidas do registry ou marcadas como bloqueadas.
- [ ] Deploys com imagem suspeita pausados.
- [ ] Pods/hosts afetados isolados.
- [ ] Logs de runtime, rede e cloud preservados.
- [ ] Imagem reconstruida a partir de base e lockfiles confiaveis.
