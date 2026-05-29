# Supply Chain Audit Adapter for Codex

Use this adapter only when a team intentionally wants project-level Codex instructions. Prefer the global `supply-chain-audit` skill for one-off audits.

Default mode is audit-only:

- Read the project and evidence.
- Do not create files in this repo by default.
- Do not edit code, workflows, lockfiles or configs unless explicitly requested.
- Do not run `npm install`, `pnpm install`, `yarn install`, `composer install`, builds, migrations or deploys before triage.
- Do not download dumps, leaked personal data or material from criminal forums.
- Classify evidence before saying compromise or breach is confirmed.

When auditing, produce findings with severity, evidence, impact, IOC, MITRE ATT&CK when applicable, exploitability and concrete correction.

If evidence indicates active compromise, begin with `ALERTA CRITICO: possivel comprometimento ativo` and list containment, secrets to rotate and evidence to preserve.
