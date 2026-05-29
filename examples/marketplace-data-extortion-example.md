# Exemplo: Marketplace Data Extortion

Este exemplo usa uma empresa ficticia para demonstrar como preparar uma entrada para o prompt principal quando surge uma alegacao publica de vazamento ou extorsao de dados em marketplace, delivery ou e-commerce.

Nao use dumps reais, dados pessoais reais, links para foruns criminosos ou amostras nao autorizadas. O objetivo e orientar triagem defensiva e resposta a incidente.

## Objetivo do exemplo

Validar se o LLM consegue identificar:

- Que uma alegacao publica nao e confirmacao de incidente.
- Como classificar evidencia entre `alegacao`, `amostra verificada`, `confirmacao interna`, `confirmacao oficial` e `incidente descartado`.
- Quais sistemas poderiam originar dados pessoais em larga escala.
- Como diferenciar token de pagamento, last4, BIN, bandeira e cartao completo.
- Quando acionar DPO/encarregado, juridico, fraude, suporte e comunicacao.

## Arquivos que o usuario deve fornecer

```text
incident timeline
data inventory
data flow diagram
API gateway logs
WAF/CDN logs
application logs
CRM/support audit logs
BI/data lake audit logs
payment provider integration docs
processor/subprocessor inventory
sanitized sample verification notes
ANPD communication draft, if applicable
```

## Entrada de exemplo para o LLM

Use o prompt em `prompts/supply-chain-security-audit.md` e anexe os dados sanitizados abaixo.

### threat-intel-report.txt

```text
2026-05-28 15:20 UTC
Fonte: threat intelligence digest
Status: alleged data extortion
Alvo alegado: FoodBox Brasil (empresa ficticia)
Volume alegado: 12.4M records
Campos alegados: name, cpf_hash, phone_masked, email, address_city, order_count, card_last4, card_brand
Observacao: nenhuma amostra bruta foi baixada ou redistribuida.
```

### sanitized-sample-verification.md

```text
Status da amostra: sanitizada por equipe interna autorizada
Tamanho: 20 linhas
Dados pessoais: removidos ou mascarados
Resultado:
- 12 emails mascarados batem com usuarios reais
- 8 registros nao encontrados
- card_last4 e card_brand batem com metadata tokenizada do PSP
- nenhum PAN completo ou CVV identificado
Conclusao preliminar: amostra parcial plausivel, origem ainda nao confirmada
```

### system-inventory.md

```text
Sistemas com dados semelhantes:
- customer-api: nome, email, telefone, endereco
- order-service: pedidos, restaurantes, entregas
- support-crm: tickets, telefone, email, endereco parcial
- antifraud-vault: device_id, IP, payment fingerprint
- data-lake-prod: tabelas agregadas de pedidos e clientes
- payment-service: PSP token, card_last4, card_brand, BIN
```

### access-log-excerpt.txt

```text
2026-05-27T23:10:03Z actor=svc-bi-export action=query table=customer_profile rows=12000000 result=success
2026-05-27T23:15:44Z actor=svc-bi-export action=export path=s3://prod-analytics-exports/customer_profile_20260527.csv result=success
2026-05-28T00:02:11Z actor=partner-support-app action=read endpoint=/support/customer/search volume=high result=success
```

## Riscos que o prompt deve encontrar

- O status inicial deve ser `alegacao` ou `amostra verificada`, nao `confirmacao oficial`.
- A amostra sanitizada plausivel exige preservacao de logs, mas nao prova origem sem trilha interna.
- `svc-bi-export` exportou volume anormal e deve ser investigado.
- `partner-support-app` pode indicar risco de terceiro/processador ou abuso de credencial.
- `card_last4`, `card_brand` e BIN/metadata nao sao equivalentes a PAN completo ou CVV.
- DPO/juridico devem avaliar risco ou dano relevante e comunicacao ANPD/titulares.
- Comunicacao publica deve alertar contra golpes sem afirmar fatos nao confirmados.

## Formato esperado da resposta

O LLM deve produzir findings no formato:

| ID | Severidade | Categoria | Evidencia | Impacto | IOC | MITRE ATT&CK | Exploitabilidade | Correcao |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| DBR-001 | Alto | Data breach/LGPD | `svc-bi-export` exportou 12M linhas de `customer_profile` antes da alegacao | Possivel origem de dataset ou exposicao indevida de dados pessoais | `svc-bi-export`, `customer_profile_20260527.csv` | T1005, T1041 | Requer credencial/servico com acesso ao data lake | Preservar logs, suspender credencial, validar destino do export, acionar DPO/juridico |

## Validacoes manuais recomendadas

```bash
# Exemplos defensivos; adapte aos sistemas internos autorizados.
grep -R "svc-bi-export\\|partner-support-app\\|customer_profile_20260527" logs/ 2>/dev/null
```

Nao baixe, redistribua ou cole dumps reais em ferramentas de IA. Trabalhe com amostras sanitizadas e cadeia de custodia autorizada.
