# Exemplo: Resposta a Incidente em Vercel

Este exemplo mostra como preparar uma entrada para o prompt principal quando a organizacao usa Vercel e precisa investigar risco de SaaS/OAuth, env vars e deployments suspeitos.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- O caso como incidente de plataforma/SaaS/OAuth, nao como pacote npm comprometido sem evidencia.
- Necessidade de revisar activity logs, env var reads, deployments e integrations.
- Rotacao de secrets no sistema de origem.
- Preservacao de logs antes de remover deployments ou integrations.
- Relacao entre Vercel, Git provider, identity provider e cloud.

## Arquivos que o usuario deve fornecer

```text
Vercel activity logs
lista de deployments recentes
inventario de env vars por ambiente
lista de integrations e OAuth apps
Git provider audit logs
identity provider logs
cloud audit logs
vercel.json
.github/workflows/*
package.json
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os dados sanitizados abaixo.

### Activity log excerpt

```text
2026-04-20T02:13:44Z user=contractor@example.com action=project.env.read project=billing-portal env=production
2026-04-20T02:15:02Z user=contractor@example.com action=deployment.created project=billing-portal target=production source=git
2026-04-20T02:18:21Z user=contractor@example.com action=integration.connected app=third-party-ai-helper
```

### Deployment inventory

```text
deployment=dpl_abc123 project=billing-portal target=production commit=9f12aaa author=contractor@example.com status=ready
deployment=dpl_def456 project=billing-portal target=preview commit=unknown author=bot@example.com status=ready
```

### Env var inventory

```text
DATABASE_URL=production
STRIPE_SECRET_KEY=production
JWT_SECRET=production
NEXT_PUBLIC_ANALYTICS_ID=production,preview
DEPLOYMENT_PROTECTION_TOKEN=production
```

## Riscos que o prompt deve encontrar

- `project.env.read` em producao exige rotacao dos secrets lidos ou potencialmente acessiveis.
- Deployment production por usuario inesperado precisa ser investigado antes de deletar evidencias.
- Integration/OAuth app de terceiro deve ser revisado e removido se nao for confiavel.
- Deployment Protection token deve ser rotacionado se exposto.
- Git provider e identity provider precisam ser auditados para confirmar origem da sessao.
- Nao afirmar pacote Vercel/Next.js comprometido sem evidencia de package tampering.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| VCL-001 | Alto | SaaS/OAuth env exposure | Activity log mostra `project.env.read` em producao | Secrets podem ter sido lidos e reutilizados fora da Vercel | `contractor@example.com`, `project.env.read`, `DATABASE_URL` | T1552 | Conta ou OAuth app com acesso ao projeto | Preservar logs, revogar sessoes, remover app, rotacionar secrets no provedor de origem |

## Validacoes manuais recomendadas

```bash
vercel teams ls
vercel projects ls
vercel env ls
vercel inspect <deployment-url>
```

Use a CLI apenas com conta autorizada e preserve exportacoes de logs antes de limpar deployments, integrations ou usuarios.
