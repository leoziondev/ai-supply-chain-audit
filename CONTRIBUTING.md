# Contribuindo

Obrigado por contribuir com este toolkit. O foco do projeto e defesa, auditoria autorizada, hardening e resposta a incidente.

## Padrao de contribuicao

Antes de enviar uma alteracao:

- Use portugues claro e tecnico.
- Evite linguagem promocional ou generica.
- Inclua evidencias, criterios de validacao e limitacoes.
- Nao adicione payloads ofensivos, exploits funcionais ou instrucoes para roubo de credenciais.
- Remova parametros de tracking de links.
- Mantenha os exemplos autocontidos e seguros.
- Atualize `CHANGELOG.md` quando a mudanca alterar prompt, checklist, adapter, skill, template ou comportamento publico.
- Rode `powershell -ExecutionPolicy Bypass -File scripts/validate-content.ps1` antes de abrir PR.

## Issues e pull requests

Use os templates em `.github/ISSUE_TEMPLATE/` para bugs, problemas de conteudo de seguranca e pedidos de checklist/exemplo.

Pull requests devem:

- explicar o risco ou caso de uso;
- citar referencias publicas quando houver;
- evitar conclusoes nao evidenciadas;
- manter o modo audit-only por padrao;
- nao instruir usuarios a clonar este repo dentro de projetos auditados.

## Novos exemplos

Cada exemplo deve responder:

- Quais arquivos o usuario deve fornecer?
- Que tipo de risco o prompt deve encontrar?
- Como deve ser o formato esperado da resposta?

Inclua somente dados ficticios ou sanitizados. Nao inclua secrets reais, dominios internos, tokens, emails pessoais ou IPs privados de clientes.

## Novos checklists

Checklists devem ser praticos e verificaveis. Prefira itens que possam ser confirmados por arquivo, configuracao, log, metadata de registry ou ferramenta defensiva.

## Mudancas no prompt principal

Mudancas em `prompts/supply-chain-security-audit.md` devem preservar:

- Formato obrigatorio de resposta.
- Tabela de findings com evidencia, impacto, IOC, MITRE ATT&CK, exploitabilidade e correcao.
- Regra de interrupcao para comprometimento critico.
- Linguagem defensiva/autorizada.

## Revisao

Uma contribuicao esta pronta quando:

- Markdown renderiza corretamente.
- Links estao limpos.
- Exemplos nao contem credenciais reais.
- A alteracao melhora a capacidade de auditoria ou resposta defensiva.
- `scripts/validate-content.ps1` passa localmente.
- `CHANGELOG.md` foi atualizado quando aplicavel.
