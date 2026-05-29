# Agent Usage Matrix

| Agente | Modo recomendado | Arquivo/template | Observacao |
| --- | --- | --- | --- |
| Codex | Skill global | `skills/supply-chain-audit/` | Melhor opcao para reutilizar sem tocar no projeto auditado. |
| Codex | Regra por repo opcional | `adapters/codex/AGENTS.md` | Use apenas quando a equipe quiser versionar instrucoes. |
| Claude Code | Memoria global/user | `adapters/claude-code/CLAUDE.md` | Mantenha curto; project `CLAUDE.md` somente com aprovacao do time. |
| Cursor | User Rules globais | `adapters/cursor/supply-chain-audit.mdc` | Project Rule so para repos que querem essa politica versionada. |
| OpenCode | Regra global | `adapters/opencode/AGENTS.md` | Pode ir em `~/.config/opencode/AGENTS.md`. |
| OpenCode | Agent audit-only | `adapters/opencode/supply-chain-audit-agent.md` | Preferir quando quiser permissoes restritas. |

## Politica comum

- Ler primeiro, perguntar depois.
- Nao modificar projeto auditado por padrao.
- Nao executar installs/builds antes da triagem.
- Nao baixar dumps ou dados pessoais reais.
- Classificar evidencia antes de afirmar incidente.
- Produzir findings com evidencia, impacto, IOC, MITRE quando aplicavel, exploitabilidade e correcao.
