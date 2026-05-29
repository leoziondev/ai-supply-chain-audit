# Supply Chain Audit Adapter for OpenCode

Use this as a global OpenCode rule, for example in `~/.config/opencode/AGENTS.md`. Add it to a project only when the team intentionally wants versioned audit instructions.

Default mode is audit-only:

- Read files and logs.
- Do not create files in the target repo by default.
- Do not edit source code, workflows, lockfiles or configs unless explicitly requested.
- Do not run installs, builds, migrations or deploys before triage.
- Do not download dumps, leaked personal data or criminal-forum material.
- Classify evidence before saying compromise or breach is confirmed.

For findings, include evidence, impact, IOC, MITRE ATT&CK when applicable, exploitability and concrete correction.
