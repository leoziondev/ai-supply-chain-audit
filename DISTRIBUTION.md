# Distribution Guide

Este repositorio e a fonte do toolkit. Nao clone nem copie este repo para dentro de projetos auditados por padrao.

## Modelo recomendado

Use uma instalacao global ou sob demanda:

- Codex: instale `skills/supply-chain-audit/` em `~/.codex/skills/supply-chain-audit/`.
- Claude Code: use `adapters/claude-code/CLAUDE.md` como memoria de usuario ou projeto somente quando o time quiser versionar a regra.
- Cursor: use User Rules globais ou importe `adapters/cursor/supply-chain-audit.mdc` como Project Rule apenas em repos que querem essa regra versionada.
- OpenCode: use `adapters/opencode/AGENTS.md` em `~/.config/opencode/AGENTS.md` ou o agent markdown em `adapters/opencode/supply-chain-audit-agent.md`.
- Uso manual: copie o conteudo de `prompts/supply-chain-security-audit.md` para o LLM autorizado e anexe os arquivos do projeto auditado.

## Regra de projeto auditado

Por padrao, uma auditoria:

- le arquivos do projeto auditado;
- nao cria arquivos no projeto auditado;
- nao edita codigo;
- nao executa `npm install`, `composer install`, builds ou migrations antes da triagem;
- nao baixa dumps, amostras reais de vazamento ou material de foruns criminosos;
- classifica evidencia antes de afirmar comprometimento.

Relatorios so devem ser salvos no projeto auditado quando o usuario pedir explicitamente.

## Quando usar adapter por projeto

Use `AGENTS.md`, `CLAUDE.md` ou `.cursor/rules/*.mdc` dentro de um projeto auditado apenas quando:

- a equipe quer versionar instrucoes de auditoria naquele repositorio;
- a regra foi aprovada pelo time responsavel;
- o arquivo deixa claro que o modo padrao e audit-only;
- o arquivo nao copia este toolkit inteiro.

## Quando nao usar adapter por projeto

Nao adicione adapters ao projeto auditado quando:

- a auditoria for pontual;
- o projeto pertencer a cliente/terceiro;
- o objetivo for apenas revisar evidencias;
- o time nao quer arquivos auxiliares no repo.

Nesse caso, use skill global ou prompt manual.
