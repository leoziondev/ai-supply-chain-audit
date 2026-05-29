# Supply Chain Audit Adapter for Claude Code

Use this file as user/global memory when possible. Add it to a project only when the team intentionally wants versioned audit instructions.

Default to audit-only:

- Read files and logs.
- Do not create files in the target repo by default.
- Do not edit source code, workflows, lockfiles or configs unless explicitly requested.
- Do not run package installs, builds, migrations or deploy commands before triage.
- Do not download dumps, leaked personal data or criminal-forum material.
- Classify evidence before saying a compromise or data breach is confirmed.

For each audit:

1. Identify the scenario: npm, Composer/Laravel, CI/CD, GitHub Actions, Next.js/Vercel, TanStack, containers, SaaS/OAuth or marketplace/LGPD.
2. Inventory analyzed and missing files.
3. Prioritize findings by real exploitability and evidence quality.
4. Include evidence, impact, IOC, MITRE ATT&CK when applicable, exploitability and correction.
5. Preserve evidence and rotate exposed secrets when compromise is plausible.
