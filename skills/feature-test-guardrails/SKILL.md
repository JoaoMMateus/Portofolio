---
name: feature-test-guardrails
description: Every new feature must ship with tests running in CI (GitHub Actions or GitLab CI), green before merge; after merge tests are frozen unless the tested core functionality changed.
---

# Feature Test Guardrails

## Tests are mandatory
- Every new feature (every approved US on its feature branch) must include automated tests covering its behavior and acceptance criteria.
- Tests live with the code on the same feature branch (e.g. `tests/` or the repo's conventional test location).

## CI is mandatory
- Tests must run in the repository's pipeline: a GitHub Actions workflow (`.github/workflows/`) or a GitLab CI pipeline (`.gitlab-ci.yml`).
- If no pipeline exists yet, create the minimal pipeline entry that runs the tests on every push and pull request/merge request.
- The pipeline must be green before the feature branch is merged.

## Post-merge test immutability
- Once a feature is merged, its tests must NOT be changed, weakened, or deleted.
- Exception: tests may be updated only when the core functionality they test has genuinely changed — for example the function now returns more values, returns them in a different format, or accepts different inputs. In that case, update the tests in the same change that modifies the functionality, and say so in the US/changelog.
- Cosmetic refactors that do not change tested behavior must not touch the tests.

## Who writes the tests
- Tests may be written by a different agent or model than the one implementing the feature, as long as the tests still follow all rules above: they run in CI, they pass before merge, and they are frozen after merge unless the tested core functionality changes.
