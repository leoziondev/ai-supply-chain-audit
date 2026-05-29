# Checklist: Marketplace, Delivery e E-commerce

## Dados e dominios de negocio

- [ ] Fluxos de consumidor, restaurante/lojista, entregador, suporte e financeiro foram mapeados.
- [ ] Dados pessoais por ator foram inventariados.
- [ ] Dados de pedido, entrega, endereco, chat e comprovantes foram classificados.
- [ ] Dados de pagamento foram separados entre provedor de pagamento, token, metadata e dados sensiveis.
- [ ] Logs e analytics nao armazenam dados pessoais alem do necessario.

## APIs e aplicacao

- [ ] APIs de perfil, pedidos, enderecos, pagamentos, suporte e admin foram revisadas.
- [ ] BOLA/IDOR, broken access control e mass assignment foram avaliados.
- [ ] Exportacoes em massa exigem justificativa, MFA, aprovacao e logging.
- [ ] Rate limits e deteccao de scraping foram revisados.
- [ ] Erros e respostas de API nao retornam dados de outros usuarios.

## Operacoes internas

- [ ] Admin panels usam RBAC minimo e revisao periodica.
- [ ] Acesso de suporte e operacoes e auditado por usuario, motivo e ticket.
- [ ] Ferramentas de BI e data lake usam row-level security quando aplicavel.
- [ ] Exports de dados possuem expiracao, criptografia e trilha de auditoria.
- [ ] Ambientes de desenvolvimento nao usam dados reais sem mascaramento.

## Terceiros e fornecedores

- [ ] Processadores/subprocessadores com acesso a dados pessoais foram listados.
- [ ] Contratos e DPAs exigem seguranca, notificacao de incidente e minimizacao.
- [ ] Integracoes com CRM, antifraude, pagamentos, atendimento e marketing foram revisadas.
- [ ] Chaves de API de terceiros possuem escopo minimo e rotacao.
- [ ] Webhooks e callbacks validam assinatura, origem e replay.

## Resposta a fraude

- [ ] Foram definidos sinais para phishing usando a marca.
- [ ] Foram definidos sinais para account takeover e credential stuffing.
- [ ] Cartoes virtuais, chargebacks e compras anormais foram monitorados.
- [ ] Atendimento sabe orientar usuarios sem pedir dados sensiveis fora dos canais oficiais.
- [ ] Comunicacoes publicas orientam usuarios a usar apenas app/site oficial.
