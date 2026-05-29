# No Project Mutation Policy

Default behavior:

- Do not create reports in the target project.
- Do not add adapters, prompts, checklists or templates to the target project.
- Do not edit source code, workflows, lockfiles or configs.
- Do not run package installs, build scripts, migrations or deploys before triage.
- Do not remove suspicious files before evidence preservation.

Allowed without extra confirmation:

- Read files.
- Search with `rg`.
- Inspect Git status/logs.
- Run non-mutating metadata commands.
- Suggest commands the user can run.

Ask first when:

- Saving a report in the target project.
- Applying fixes.
- Running installs/builds/tests that execute project code.
- Pulling external data.
- Adding project-level agent instructions.
