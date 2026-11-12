# Agent Skills (workspace)

These workspace skills are active in every session and project. Follow them at all times.

## 1. Project Memory Shards (`project-memory-shards`)

### Purpose
Every folder in a project carries a `MEMORY_SHARD.md` file that acts as the folder's memory: what it contains, what it does, who calls it, and what changed over time.

### Creating a shard
When you enter a project (or create a new folder), check whether `MEMORY_SHARD.md` exists in each folder. If it does not, create it using this template:

```markdown
# Memory Shard: <folder path>

## Contains
- <what lives in this folder: files, modules, responsibilities>

## Does
- <what this folder is responsible for, in one or two sentences>

## Called by
- <files, modules, or entry points that import/use this folder, with paths>

## Changelog
| Date | Commit | What changed |
|------|--------|--------------|
| YYYY-MM-DD | <commit hash> | <description of the change> |
```

### Keeping a shard up to date
- Whenever you add, remove, or modify a file in the folder, append a row to the Changelog with the current date, the commit hash (use `git log` / `git rev-parse` when available; otherwise note "uncommitted"), and a short description of what changed.
- When the folder's contents or its callers change, update the Contains / Does / Called by sections accordingly.
- Derive "Called by" by searching the codebase for imports, references, or calls into the folder (e.g. grep for the module/folder name).
- Never delete historical changelog rows; the shard is an append-only log plus the current-state sections.

## 2. User Story Workflow (`user-story-workflow`)

### US folder
- At the project root, maintain a `US/` folder.
- Each new feature request gets its own Markdown file: `US/US-<id>-<short-slug>.md`, where `<id>` is a sequential number (US-001, US-002, ...).

### US file template
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

### Review gate (code mode only)
- When a new feature request arrives and the session is in code mode (writing/changing code), FIRST create the US file with status `proposed`, THEN ask the user to review it.
- Do not write any code for the feature until the user explicitly approves the US. On approval, set status to `approved`.
- This gate does not apply in work/planning mode (discussion, design, estimation): there you may draft US files without blocking.

### Sync with the issue tracker
- When a US is created, also create the corresponding item in the repository's issue management: a GitHub issue or a GitLab work item, and record its URL/number in the US file.
- Keep statuses in sync in both directions: when the US status changes, update the issue/work item (labels, state, or milestone) and vice versa.
- When the US is closed, close the linked issue/work item (see skill 3).

## 3. Feature Branch Lifecycle (`feature-branch-lifecycle`)

### Branching
- For every new feature (each approved US), always create a dedicated branch before writing code:
  - `feature/US-<id>-<short-slug>`
- Do not implement features directly on the main/master branch.

### Merging
- When the feature is complete and its tests pass (see skill 4), open a pull request / merge request from the feature branch into the main branch and merge it.

### Closing after merge
- Once the merge is completed:
  1. Set the US file's status to `closed` in `US/US-<id>-<slug>.md`, adding the merge commit hash and date.
  2. Close the linked GitHub issue or GitLab work item, with a comment referencing the US and the merge commit.
- The US and the issue/work item must never remain open after the merge that delivers the feature.

## 4. Feature Test Guardrails (`feature-test-guardrails`)

### Tests are mandatory
- Every new feature (every approved US on its feature branch) must include automated tests covering its behavior and acceptance criteria.
- Tests live with the code on the same feature branch (e.g. `tests/` or the repo's conventional test location).

### CI is mandatory
- Tests must run in the repository's pipeline: a GitHub Actions workflow (`.github/workflows/`) or a GitLab CI pipeline (`.gitlab-ci.yml`).
- If no pipeline exists yet, create the minimal pipeline entry that runs the tests on every push and pull request/merge request.
- The pipeline must be green before the feature branch is merged.

### Post-merge test immutability
- Once a feature is merged, its tests must NOT be changed, weakened, or deleted.
- Exception: tests may be updated only when the core functionality they test has genuinely changed — for example the function now returns more values, returns them in a different format, or accepts different inputs. In that case, update the tests in the same change that modifies the functionality, and say so in the US/changelog.
- Cosmetic refactors that do not change tested behavior must not touch the tests.

### Who writes the tests
- Tests may be written by a different agent or model than the one implementing the feature, as long as the tests still follow all rules above: they run in CI, they pass before merge, and they are frozen after merge unless the tested core functionality changes.
