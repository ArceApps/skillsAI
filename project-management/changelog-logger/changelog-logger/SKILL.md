---
name: changelog-logger
description: Update the status and log of an existing task. Use this skill to mark items as complete, append entries to the work log (Bitácora), or close a task. DOES NOT create new plans.
allowed-tools: Read, Replace, Write, Run Command
---

# Changelog Logger & Updater

This skill is the **Scribe**. It maintains the "Living Task Document" by recording progress and events in real-time.

## When to Use

- "I finished step 3."
- "Log that we had an error with Hilt injection."
- "Mark the task as completed."
- "Update the metrics."

## Capabilities

### 1. Update Bitácora (Append Log)
You must find the `## 3. 📝 Bitácora de Trabajo` section and **APPEND** a new entry at the bottom of the list, preserving previous entries.

**Format:**
```markdown
### [YYYY-MM-DD HH:MM] - [Title]
- **Context:** [Brief context]
- **Status:** ✅ Done | ⚠️ Issue | ❌ Blocked
```

### 2. Update Progress (Checkboxes)
Find the specific checkbox in `## 2. 🧠 Plan de Ejecución` and change `[ ]` to `[x]`.

### 3. Close Task
1. Update Metadata at the top: `Estado: ✅ COMPLETADO`.
2. Fill in `## 📊 Métricas y Resultados`.

## Critical Rules

1.  **NEVER Overwrite:** Always append to the log. Do not delete history.
2.  **No Code Changes:** You manipulate Markdown files in `tasks/`, never source code.
3.  **Validation:** Run `./.forge/skills/create-plan/validate-plan.sh` after edits.

## Example Instruction

"Log that I fixed the ViewModel bug using a SideEffect."

**Action:**
1. Read `tasks/CURRENT_TASK.md`.
2. Append to Bitácora:
   ```markdown
   ### [2026-01-15 10:45] Bug Fix ViewModel
   - **Context:** Crash on rotation.
   - **Solution:** Used `LaunchedEffect` instead of `init`.
   - **Status:** ✅ Fixed
   ```
3. **MANDATORY:** Run `./.forge/skills/create-plan/validate-plan.sh tasks/CURRENT_TASK.md` to ensure integrity.
4. Save.