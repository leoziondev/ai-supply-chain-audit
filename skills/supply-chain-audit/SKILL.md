---
name: supply-chain-audit
description: Evidence-first audit workflow for supply chain, dependency malware, CI/CD, GitHub Actions, npm, Composer/Laravel, Next.js, Vercel, TanStack, containers, SaaS/OAuth incidents, marketplace data breaches and LGPD/privacy response. Use when Codex needs to assess security risk without modifying the target project by default.
---

# Supply Chain Audit

Use this skill to audit a target project or evidence bundle without polluting the target repository.

## Operating Mode

Default to audit-only:

- Read files and logs.
- Do not create, edit or delete files in the target project unless the user explicitly asks.
- Do not run `npm install`, `pnpm install`, `yarn install`, `composer install`, builds, migrations or deploy commands before triage.
- Do not download dumps, leaked personal data or material from criminal forums.
- Classify evidence before saying a compromise or breach is confirmed.

## Workflow

1. Identify the scenario using `references/scenario-router.md`.
2. Load only the relevant checklist/template references.
3. Inventory files reviewed and files missing.
4. Classify evidence using `references/evidence-levels.md`.
5. Produce findings using `references/output-contract.md`.
6. Apply `references/no-project-mutation.md` before any action that writes to the target project.

## Required Finding Shape

Each finding must include:

- ID
- Severity
- Category
- Evidence
- Impact
- IOC or observable
- MITRE ATT&CK when applicable
- Exploitability
- Concrete correction

## Escalation

If evidence indicates active compromise, start with:

`ALERTA CRITICO: possivel comprometimento ativo`

Then list immediate containment, secrets to rotate, affected systems and evidence to preserve.
