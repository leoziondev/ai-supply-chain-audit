# Resposta a Incidente: Dependencia, Pipeline ou Vazamento de Dados

Use este template quando houver suspeita de malware em dependencia, lockfile contaminado, runner comprometido, token exfiltrado, artifact poisoning, exposicao de dados pessoais, extorsao de dados ou incidente envolvendo operador/processador.

## 1. Declaracao inicial

- Data/hora de deteccao:
- Responsavel:
- Sistema afetado:
- Fonte do alerta:
- Status da evidencia: alegacao | amostra verificada | confirmacao interna | confirmacao oficial | incidente descartado
- Severidade inicial:
- Hipotese:

## 2. Criterios de acionamento

Marque o que se aplica:

- [ ] Pacote suspeito aparece em manifest ou lockfile.
- [ ] Script de lifecycle executou em ambiente com secrets.
- [ ] CI/CD runner executou codigo nao confiavel.
- [ ] Houve outbound suspeito para dominio/IP nao esperado.
- [ ] Secrets foram expostos em logs, ambiente ou arquivo.
- [ ] Artifact de origem nao confiavel foi usado em release/deploy.
- [ ] Evidencia de persistencia ou RAT.
- [ ] Env vars, deployments ou activity logs de plataforma SaaS indicam acesso suspeito.
- [ ] OAuth app, integration ou developer tool teve acesso excessivo.
- [ ] Trusted publisher/OIDC pode ter sido usado por workflow contaminado.
- [ ] Report de threat intelligence ou extorsao alega vazamento de dados.
- [ ] Amostra sanitizada foi validada contra sistemas internos.
- [ ] API, CRM, suporte, BI, data lake, bucket ou exportacao apresentou acesso suspeito.
- [ ] Dados pessoais podem gerar risco ou dano relevante aos titulares.

## 3. Acoes 0-4 horas

- [ ] Pausar releases e deploys automaticos.
- [ ] Isolar runners ou hosts possivelmente afetados.
- [ ] Preservar logs de CI/CD, endpoint, rede, cloud e registry.
- [ ] Capturar lockfiles, manifestos e checksums dos artifacts.
- [ ] Exportar activity logs, identity provider logs, deployment list e integration inventory.
- [ ] Revogar e rotacionar tokens de npm, Composer, GitHub, cloud, SSH e banco.
- [ ] Revogar sessoes, OAuth grants, deployment protection tokens e tokens de plataforma.
- [ ] Bloquear dominios/IPs suspeitos em DNS, proxy e firewall.
- [ ] Acionar AppSec, SecOps, engenharia, DPO/encarregado, juridico, privacidade, fraude, suporte e comunicacao.
- [ ] Avaliar obrigacao de comunicacao a ANPD e titulares.
- [ ] Preparar comunicacao antifraude para golpes usando a marca.

## 4. Evidencias a preservar

| Evidencia | Local | Responsavel | Status |
| --- | --- | --- | --- |
| Lockfiles |  |  |  |
| Logs de CI/CD |  |  |  |
| Logs de rede |  |  |  |
| CloudTrail/audit logs |  |  |  |
| Artifacts publicados |  |  |  |
| Imagens de container |  |  |  |
| Activity logs de deploy platform |  |  |  |
| Identity provider logs |  |  |  |
| OAuth apps/integrations |  |  |  |
| Trusted publisher settings |  |  |  |
| Amostra sanitizada/verificacao |  |  |  |
| CRM/support audit logs |  |  |  |
| BI/data lake audit logs |  |  |  |
| API gateway/WAF/CDN logs |  |  |  |
| Inventario de terceiros/processadores |  |  |  |

## 5. Escopo e impacto

- Repositorios afetados:
- Ambientes afetados:
- Runners afetados:
- Secrets potencialmente expostos:
- Releases/deploys afetados:
- Projetos Vercel/deploy platform afetados:
- OAuth apps/integrations afetadas:
- Trusted publishers afetados:
- Clientes ou dados regulados envolvidos:
- Categorias de dados pessoais afetadas:
- Operadores/processadores envolvidos:
- Bases/sistemas provaveis de origem:
- Necessidade de comunicacao ANPD/titulares:

## 6. Triagem de amostra ou dump

| Item | Resultado | Observacao |
| --- | --- | --- |
| Fonte da alegacao |  | Nao incluir links para dumps ou foruns criminosos |
| Amostra recebida por canal autorizado |  |  |
| Dados pessoais removidos/sanitizados |  |  |
| Campos alegados |  | Ex.: nome, CPF, telefone, endereco, pedido, token de pagamento |
| Match com sistemas internos |  |  |
| Sinais de dataset reciclado/enriquecido |  |  |
| Conclusao de confianca |  | alegacao/amostra verificada/confirmacao interna/confirmacao oficial/incidente descartado |

## 7. IOCs

| Tipo | Valor | Fonte | Acao |
| --- | --- | --- | --- |
| Pacote |  |  |  |
| Versao |  |  |  |
| Dominio |  |  |  |
| IP |  |  |  |
| Path |  |  |  |
| Hash |  |  |  |
| OAuth app ID |  |  |  |
| Deployment ID |  |  |  |
| Workflow run |  |  |  |
| Dataset/sample ID interno |  |  |  |
| Export job/query ID |  |  |  |

## 8. Erradicacao e recuperacao

- [ ] Remover dependencia ou versao afetada.
- [ ] Regenerar lockfile a partir de fonte confiavel.
- [ ] Recriar runners e hosts efemeros.
- [ ] Rebuildar imagens e artifacts com cadeia validada.
- [ ] Publicar release corrigida.
- [ ] Validar que nenhum token antigo permanece ativo.
- [ ] Remover OAuth apps/integrations suspeitas.
- [ ] Revisar e corrigir trusted publisher/OIDC bindings.
- [ ] Remover ou reverter deployments suspeitos apos preservar evidencias.
- [ ] Revogar credenciais de APIs, CRM, BI, data lake, suporte e parceiros afetados.
- [ ] Corrigir endpoint, permissao, exportacao, bucket, query, pipeline ou integracao vulneravel.
- [ ] Revisar mascaramento, tokenizacao, retencao, RBAC e logging de exportacao.
- [ ] Reabilitar deploy apenas apos aprovacao.

## 9. Comunicacao, LGPD e titulares

- [ ] DPO/encarregado avaliou risco ou dano relevante.
- [ ] Juridico avaliou comunicacao a ANPD e titulares.
- [ ] Conteudo de comunicacao evita especulacao e descreve medidas adotadas.
- [ ] Suporte recebeu roteiro antifraude e orientacao de atendimento.
- [ ] Canais oficiais foram preparados para alertar contra phishing, links externos e golpes usando a marca.
- [ ] Evidencias e decisoes foram registradas para auditoria.

## 10. Pos-incidente

- [ ] Adicionar SBOM em builds.
- [ ] Pinning por versao, SHA ou digest onde aplicavel.
- [ ] Reduzir permissoes de CI/CD.
- [ ] Separar jobs com secrets de jobs que executam codigo nao confiavel.
- [ ] Adotar mirrors/proxies com politica de scan.
- [ ] Adicionar deteccoes para lifecycle hooks, outbound suspeito e acesso a metadata cloud.
- [ ] Adicionar CODEOWNERS para workflows, lockfiles, publish configs e IaC.
- [ ] Revisar periodicamente integrations, OAuth apps, env vars e deployment protection.
- [ ] Revisar terceiros/processadores e contratos de tratamento de dados.
- [ ] Reduzir coleta, exposicao e retencao de dados pessoais.
- [ ] Implementar deteccoes para exports massivos, queries anormais e acesso a dados fora do padrao.
