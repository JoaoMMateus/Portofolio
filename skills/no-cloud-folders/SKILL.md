---
name: no-cloud-folders
description: Never search, read, or write OneDrive, Google Drive, iCloud, Dropbox, or any other cloud-synced folder; keep all work local to the project directory.
---

# No Cloud Folder Search

## Rule
- Never search, read, index, list, or write files inside cloud-synced or cloud-storage folders: Microsoft OneDrive, Google Drive, Apple iCloud Drive, Dropbox, Box, or any other cloud mount/sync folder.
- Keep all file operations local to the current project directory and its repository.

## If a request points at a cloud folder
- If a user-requested file or path appears to live in a cloud folder (path contains `OneDrive`, `Google Drive`, `iCloud`, `Dropbox`, etc.), do NOT open or search it. Stop and tell the user to copy/move the file into the project first.

## Scope
- Applies in every mode (code mode and work/planning mode) and in every session type: CLI, VS Code, and workspace sessions.
