# Checklist: Data Breach e LGPD

## Classificacao da evidencia

- [ ] A fonte da alegacao foi registrada sem incluir links para dumps ou foruns criminosos.
- [ ] O status foi classificado como `alegacao`, `amostra verificada`, `confirmacao interna`, `confirmacao oficial` ou `incidente descartado`.
- [ ] Amostras foram sanitizadas antes de qualquer analise compartilhada.
- [ ] Foi avaliado se o dataset pode ser falso, reciclado, enriquecido ou de outra fonte.
- [ ] A conclusao separa fato tecnico, hipotese, impacto regulatorio e rumor publico.

## Categorias de dados

- [ ] Nome, CPF, email, telefone e endereco foram avaliados.
- [ ] Dados de pedidos, restaurantes, entregadores, geolocalizacao e suporte foram avaliados.
- [ ] Device IDs, IPs, user agents e antifraude foram avaliados.
- [ ] Dados de pagamento foram classificados corretamente: PAN completo, CVV, token, last4, BIN, bandeira, validade truncada ou metadata.
- [ ] Nao foi assumida exposicao de cartao completo sem evidencia.

## Origem provavel

- [ ] App, API, BFF, admin panel e endpoints internos foram revisados.
- [ ] CRM, suporte, BI, data lake, warehouse e exports CSV foram revisados.
- [ ] Buckets, snapshots, backups e logs foram revisados.
- [ ] Terceiros, operadores/processadores e subprocessadores foram identificados.
- [ ] Credenciais, service accounts e tokens com acesso a dados pessoais foram revisados.

## Resposta LGPD

- [ ] DPO/encarregado foi acionado.
- [ ] Juridico avaliou risco ou dano relevante aos titulares.
- [ ] Prazo de comunicacao ANPD/titulares foi avaliado conforme regra aplicavel.
- [ ] Medidas tecnicas e organizacionais usadas para protecao foram documentadas.
- [ ] Providencias de contencao, mitigacao e comunicacao foram registradas.

## Comunicacao e fraude

- [ ] Plano de comunicacao evita afirmar fatos nao confirmados.
- [ ] Suporte recebeu roteiro contra phishing e golpes usando a marca.
- [ ] Canais oficiais foram preparados para orientar usuarios.
- [ ] Monitoramento de credential stuffing, account takeover e abuso de cartoes virtuais foi ativado.
- [ ] Indicadores de fraude foram enviados para antifraude, SIEM e atendimento.
