---
name: user-story-workflow
description: Keep a US/ folder with one Markdown user story per feature request, require review before coding in code mode, and sync each US with GitHub issues or GitLab work items.
---

# User Story Workflow

## US folder
- At the project root, maintain a `US/` folder.
- Each new feature request gets its own Markdown file: `US/US-<id>-<short-slug>.md`, where `<id>` is a sequential number (US-001, US-002, ...).

## US file template
```markdown
# US-<id>: <title>

- Status: proposed | approved | in-progress | done | closed
- Issue tracker: <GitHub issue URL/number or GitLab work item URL/iid>

## Description
As a <role>, I want <goal>, so that <benefit>.

## Acceptance criteria
- [ ] ...

## Notes
- ...
```

## Review gate (code mode only)
- When a new feature request arrives and the session is in code mode (writing/changing code), FIRST create the US file with status `proposed`, THEN ask the user to review it.
- Do not write any code for the feature until the user explicitly approves the US. On approval, set status to `approved`.
- This gate does not apply in work/planning mode (discussion, design, estimation): there you may draft US files without blocking.

## Sync with the issue tracker
- When a US is created, also create the corresponding item in the repository's issue management: a GitHub issue or a GitLab work item, and record its URL/number in the US file.
- Keep statuses in sync in both directions: when the US status changes, update the issue/work item (labels, state, or milestone) and vice versa.
- When the US is closed, close the linked issue/work item (see the feature-branch-lifecycle skill).
