# Checklist: Vercel Security e Incident Review

## Identidade e acesso

- [ ] MFA/passkeys habilitados para usuarios e administradores.
- [ ] Membros, teams, roles e acessos a projetos revisados.
- [ ] Git provider connection revisada.
- [ ] Integrations e OAuth apps de terceiros revisados.
- [ ] Identity provider logs preservados quando houver suspeita.

## Activity logs e deployments

- [ ] Activity logs revisados para logins, env var reads, project access e changes.
- [ ] Deployments recentes revisados para origem, autor, commit e horario.
- [ ] Deployments suspeitos foram removidos ou revertidos.
- [ ] Aliases e domains foram revisados.
- [ ] Preview deployments com dados sensiveis foram avaliados.

## Environment variables

- [ ] Inventario de env vars por ambiente concluido.
- [ ] Env vars sensiveis foram marcadas/protegidas quando a plataforma permitir.
- [ ] Env vars potencialmente lidas por atacante foram rotacionadas.
- [ ] Variaveis de preview, development e production foram tratadas separadamente.
- [ ] Secrets antigos foram revogados no provedor de origem, nao apenas removidos da Vercel.

## Deployment Protection

- [ ] Deployment Protection esta habilitado no minimo para ambientes sensiveis.
- [ ] Deployment Protection tokens foram rotacionados quando houver suspeita.
- [ ] Bypass ou sharing de preview links foi revisado.
- [ ] Logs de acesso a previews sensiveis foram avaliados.

## Resposta a suspeita

- [ ] O incidente foi classificado como SaaS/OAuth/env vars/deployment quando nao houver evidencia de pacote comprometido.
- [ ] Contas afetadas tiveram sessoes revogadas.
- [ ] Integrations suspeitas foram removidas.
- [ ] Env vars foram rotacionadas nos sistemas de origem.
- [ ] Deployments e audit logs foram preservados antes de limpeza.
