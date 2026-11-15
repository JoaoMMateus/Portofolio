---
name: project-memory-shards
description: Maintain a MEMORY_SHARD.md in every folder of a project — what the folder contains, what it does, who calls it, and what changed on which date at which commit.
---

# Project Memory Shards

## Purpose
Every folder in a project carries a `MEMORY_SHARD.md` file that acts as the folder's memory: what it contains, what it does, who calls it, and what changed over time.

## Creating a shard
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

## Keeping a shard up to date
- Whenever you add, remove, or modify a file in the folder, append a row to the Changelog with the current date, the commit hash (use `git log` / `git rev-parse` when available; otherwise note "uncommitted"), and a short description of what changed.
- When the folder's contents or its callers change, update the Contains / Does / Called by sections accordingly.
- Derive "Called by" by searching the codebase for imports, references, or calls into the folder (e.g. grep for the module/folder name).
- Never delete historical changelog rows; the shard is an append-only log plus the current-state sections.
