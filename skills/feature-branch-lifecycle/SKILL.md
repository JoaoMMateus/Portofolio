---
name: feature-branch-lifecycle
description: Work on a dedicated branch for every new feature and merge it when done; once merged, mark the user story closed and close the linked GitHub issue or GitLab work item.
---

# Feature Branch Lifecycle

## Branching
- For every new feature (each approved US), always create a dedicated branch before writing code:
  - `feature/US-<id>-<short-slug>`
- Do not implement features directly on the main/master branch.

## Merging
- When the feature is complete and its tests pass (see feature-test-guardrails), open a pull request / merge request from the feature branch into the main branch and merge it.

## Closing after merge
- Once the merge is completed:
  1. Set the US file's status to `closed` in `US/US-<id>-<slug>.md`, adding the merge commit hash and date.
  2. Close the linked GitHub issue or GitLab work item, with a comment referencing the US and the merge commit.
- The US and the issue/work item must never remain open after the merge that delivers the feature.
